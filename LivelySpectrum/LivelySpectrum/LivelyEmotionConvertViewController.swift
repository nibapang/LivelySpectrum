//
//  EmotionConvertVC.swift
//  LivelySpectrum
//
//  Created by Lively Spectrum on 2025/3/5.
//


import UIKit
@available(iOS 15.0, *)

class LivelyEmotionConvertViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pullDownButton: UIButton!
    @IBOutlet weak var selectPullOptionLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    @IBOutlet weak var emotionColorViewShow: UIView!
    @IBOutlet weak var editButton: UIButton!
    
    var xValue : NSNumber = 0.0
    var yValue : NSNumber = 1.5
    var startValue : NSNumber = 0.3
    var endValue : NSNumber = 0.8
    
    
    
    var emotion: [Mood] = []
    
    var emotionColor : [String] = []{
        didSet{
            for i in emotionColor{
                print(i)
            }
            colorCollectionView.reloadData()
        }
    }
    
    var allColorView :[String] =  []{
        didSet{
            for i in allColorView{
                print(i)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { [self] in
                updateGradientView()
            })
        }
    }
    
    var titleName: String?
    var selectedIndexes = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleName
        setupMenuForPullDownButton()
        
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        editButton.applyGradient(colours: [UIColor.orange, UIColor.passion], startValue: 0.3, endValue: 0.8, radious: 8, locations: [0.0, 1.5])
    }
    
    func setupMenuForPullDownButton() {
        var menuActions: [UIAction] = []

       
        let menuClosure = { [self] (action: UIAction) in
            pullDownButton.setTitle(action.title, for: .normal)
            selectPullOptionLabel.text = action.title
            // Find the selected mood
            if let selectedMood = self.emotion.first(where: { $0.moodName == action.title }) {
                self.emotionColor = selectedMood.colorNames
                print("Updated Emotion Colors: \(self.emotionColor)")
            }
            
        }

       
        for mood in emotion {
            let action = UIAction(title: mood.moodName, handler: menuClosure)
            menuActions.append(action)
           
        }

        if let firstMood = emotion.first {
            pullDownButton.setTitle(firstMood.moodName, for: .normal)
            selectPullOptionLabel.text = firstMood.moodName
            emotionColor = firstMood.colorNames
        }
        
        
        pullDownButton.menu = UIMenu(title: "Select Emotion", children: menuActions)
        pullDownButton.showsMenuAsPrimaryAction = true
        pullDownButton.changesSelectionAsPrimaryAction = true
        
        
        colorCollectionView.reloadData()
    }
    

    
    @IBAction func btnBackTapped(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(
            title: "Edit Gradient Locations",
            message: "Enter new values for X, Y, Start, and End positions!",
            preferredStyle: .alert
        )
        
        // Add text fields for X, Y, Start, and End values
        alertController.addTextField { textField in
            textField.placeholder = "X Value (0.0 - 1.0)"
            textField.keyboardType = .decimalPad
            textField.text = "\(self.xValue)"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Y Value (0.0 - 1.0)"
            textField.keyboardType = .decimalPad
            textField.text = "\(self.yValue)"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Start Value (0.0 - 1.0)"
            textField.keyboardType = .decimalPad
            textField.text = "\(self.startValue)"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "End Value (0.0 - 1.0)"
            textField.keyboardType = .decimalPad
            textField.text = "\(self.endValue)"
        }
        
        // Add "Update" action
        let updateAction = UIAlertAction(title: "Update", style: .default) { _ in
            guard let xText = alertController.textFields?[0].text,
                  let yText = alertController.textFields?[1].text,
                  let startText = alertController.textFields?[2].text,
                  let endText = alertController.textFields?[3].text,
                  
                  let newX = Double(xText),
                  let newY = Double(yText),
                  let newStart = Double(startText),
                  let newEnd = Double(endText) else {
                print("Invalid input detected. Values not updated.")
                return
            }
            
            // Convert and validate the values
            self.xValue = NSNumber(value: min(max(newX, 0.0), 1.0)) // Clamp between 0.0 - 1.0
            self.yValue = NSNumber(value: min(max(newY, 0.0), 1.0))
            self.startValue = NSNumber(value: min(max(newStart, 0.0), 1.0))
            self.endValue = NSNumber(value: min(max(newEnd, 0.0), 1.0))
            
            print("Updated Values - X: \(self.xValue), Y: \(self.yValue), Start: \(self.startValue), End: \(self.endValue)")
            
            // Apply gradient update after value change
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.updateGradientView()
            }
        }
        
        // Add "Cancel" action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Add actions to alert
        alertController.addAction(updateAction)
        alertController.addAction(cancelAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(
            title: "How to Use",
            message: """
            1️⃣ **Select an Emotion** using the dropdown button.
            2️⃣ **Choose Colors** from the collection view to apply a gradient.
            3️⃣ **Edit Gradient Settings** using the edit button to change X, Y, Z values.
            4️⃣ **Reset Gradient** anytime using the reset button.
            5️⃣ **Your last applied settings will be saved automatically.**
            """,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "Got it!", style: .default)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    
}


@available(iOS 15.0, *)

extension LivelyEmotionConvertViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emotionColor.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorCollectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as! LivelyColorCell
        cell.colorView.backgroundColor = UIColor(named: emotionColor[indexPath.row])
        
        cell.select = indexPath.item
        cell.isSelectedCell = selectedIndexes.contains(indexPath.item)
        
        cell.colorSelection = { selectedIndex in
            let selectedColor = self.emotionColor[selectedIndex] // Get selected color
            
            if self.selectedIndexes.contains(selectedIndex) {
                self.selectedIndexes.remove(selectedIndex)
                self.allColorView.removeAll { $0 == selectedColor } // Remove color
            } else {
                self.selectedIndexes.insert(selectedIndex)
                self.allColorView.append(selectedColor) // Add color
            }
            
            self.updateGradientView() // Apply gradient update
            self.colorCollectionView.reloadItems(at: [indexPath])
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: colorCollectionView.frame.width / 3 - 10, height: colorCollectionView.frame.height - 10)
    }
    
    func updateGradientView() {
        // Convert color names (String) to UIColor
        let gradientColors = allColorView.compactMap { UIColor(named: $0) }
        
        if gradientColors.isEmpty {
            // If no color is selected, reset the view to a default color
            DispatchQueue.main.async {
                self.emotionColorViewShow.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
                self.emotionColorViewShow.backgroundColor = .lightGray
            }
        } else if gradientColors.count == 1 {
            // If only one color is selected, set it as a solid background
            DispatchQueue.main.async {
                self.emotionColorViewShow.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
                self.emotionColorViewShow.backgroundColor = gradientColors.first
            }
        } else {
            // Apply gradient with selected colors
            DispatchQueue.main.async {
                self.emotionColorViewShow.applyGradient(colours: gradientColors, startValue: 0.3, endValue: 0.8, radious: 15, locations: [self.xValue, self.yValue])
            }
        }
    }
}
