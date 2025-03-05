//
//  ColorCell.swift
//  LivelySpectrum
//
//  Created by Lively Spectrum on 2025/3/5.
//


import UIKit

class LivelyColorCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var btnSelect: UIButton!
    
    var isSelectedCell: Bool = false {
        didSet {
            updateButtonImage()
        }
    }
    
    var select: Int = 0
    var colorSelection: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateButtonImage() // Set default state
    }
    
    @IBAction func btnSelectedTapped(_ sender: Any) {
        isSelectedCell.toggle() // Toggle selection
        colorSelection?(select)
    }
    
    private func updateButtonImage() {
        let imageName = isSelectedCell ? "checkmark.circle.fill" : "circle"
        btnSelect.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    
    
}
