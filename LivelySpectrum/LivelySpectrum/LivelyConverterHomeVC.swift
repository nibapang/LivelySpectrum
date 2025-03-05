//
//  ConverterHomeVC.swift
//  LivelySpectrum
//
//  Created by Lively Spectrum on 2025/3/5.
//


import UIKit

class LivelyConverterHomeVC: UIViewController {
    
    
    @IBOutlet weak var converterTableView: UITableView!
    
    let converters = converter
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        converterTableView.register(UINib(nibName: "EmojiConverterCell", bundle: nil), forCellReuseIdentifier: "EmojiConverterCell")
        
        
        converterTableView.dataSource = self
        converterTableView.delegate = self

        
    }
}

@available(iOS 15.0, *)
extension LivelyConverterHomeVC : UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return converters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = converterTableView.dequeueReusableCell(withIdentifier: "EmojiConverterCell", for: indexPath) as! EmojiConverterCell
        let emoji = converters[indexPath.row].moodTitle
        cell.converterTitle.text = emoji
        cell.converterImage.image = UIImage(named: emoji)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "EmotionConvertVC") as! LivelyEmotionConvertViewController
        
        vc.titleName = converters[indexPath.row].moodTitle
        vc.emotion = converters[indexPath.row].mood
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
