//
//  CustomCornerView.swift
//  LivelySpectrum
//
//  Created by Lively Spectrum on 2025/3/5.
//

import UIKit

@IBDesignable
class LivelyCustomCornerView: UIView {
    
    @IBInspectable var topLeftCornerRadius: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var topRightCornerRadius: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var bottomLeftCornerRadius: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var bottomRightCornerRadius: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    private func updateCornerRadius() {
        var corners: CACornerMask = []
        
        if topLeftCornerRadius {
            corners.insert(.layerMinXMinYCorner)
        }
        if topRightCornerRadius {
            corners.insert(.layerMaxXMinYCorner)
        }
        if bottomLeftCornerRadius {
            corners.insert(.layerMinXMaxYCorner)
        }
        if bottomRightCornerRadius {
            corners.insert(.layerMaxXMaxYCorner)
        }
        
        layer.maskedCorners = corners
    }
}
