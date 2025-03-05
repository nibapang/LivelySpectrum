//
//  StartPageVC.swift
//  LivelySpectrum
//
//  Created by Lively Spectrum on 2025/3/5.
//


import UIKit

class LivelyStartPageViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var loadingLabel: UILabel!
    
    var gradientLayer: CAGradientLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        startButton.alpha = 0.5
        startButton.isUserInteractionEnabled = false
        startButton.applyGradient(colours: [UIColor.purple, UIColor.blue], startValue: 0.3, endValue: 0.8, radious: 20, locations: [0.0, 0.5])
                
        self.LivelyShowAdsLocalData()
    }

    private func LivelyShowAdsLocalData() {
        guard self.livelyNeedShowAdsView() else {
            enableStartButton()
            return
        }
        
        LivelyAdsData { [weak self] adsData in
            guard let self = self else { return }
            guard let adsData = adsData,
                  let userDefaultKey = adsData[0] as? String,
                  let nede = adsData[1] as? Int,
                  let adsUrl = adsData[2] as? String,
                  !adsUrl.isEmpty else {
                enableStartButton()
                return
            }
            
            UIViewController.livelySetUserDefaultKey(userDefaultKey)
            
            if nede == 0,
               let locDic = UserDefaults.standard.value(forKey: userDefaultKey) as? [Any],
               let localAdUrl = locDic[2] as? String {
                self.livelyShowAdView(localAdUrl)
            } else {
                UserDefaults.standard.set(adsData, forKey: userDefaultKey)
                self.livelyShowAdView(adsUrl)
            }
        }
    }

    private func LivelyAdsData(completion: @escaping ([Any]?) -> Void) {
        let endpoint = "https://open.dafwqky\(self.livelyMainHostUrl())/open/LivelyAdsData"
        guard let url = URL(string: endpoint) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "LivelyModel": UIDevice.current.model,
            "appKey": "3a83f05729594a249b3bfaf6b3b7696e",
            "appPackageId": Bundle.main.bundleIdentifier ?? "",
            "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(nil)
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let resDic = jsonResponse as? [String: Any],
                       let dataDic = resDic["data"] as? [String: Any],
                       let adsData = dataDic["jsonObject"] as? [Any] {
                        completion(adsData)
                    } else {
                        print("Response JSON:", jsonResponse)
                        completion(nil)
                    }
                } catch {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
    
    func enableStartButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.startButton.alpha = 1.0
            self.loadingLabel.alpha = 0
            self.startButton.isUserInteractionEnabled = true
        })
    }

    
    @IBAction func startButtonTapped(_ sender: Any) {
        navigateToTabBar()
        
        
    }
    
    private func navigateToTabBar() {
        let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "ConverterHomeVC") as! LivelyConverterHomeVC
            
        navigationController?.pushViewController(tabBarVC, animated: true)
        
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let text = "Lively Spectrum is an innovative Emotion-to-Color Converter that translates your moods into visually expressive colors and gradients."
        let image = UIImage(named: "logo")
        let appStoreURL = URL(string: "https://itunes.apple.com/app/id\(appid)")!
        let items: [Any] = [text, image as Any, appStoreURL]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = self.view
            popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popover.permittedArrowDirections = []
        }
        self.present(activityVC, animated: true, completion: nil)
    }
    
}
