//
//  UIView+Layer.swift
//  LivelySpectrum
//
//  Created by Lively Spectrum on 2025/3/5.
//


import UIKit


extension UIView {
    
    func applyGradient(colours: [UIColor], radious : Int, startValue : Double, endValue : Double) -> CAGradientLayer {
        return self.applyGradient(colours: colours, startValue: startValue, endValue: endValue, radious: radious, locations: nil)
    }
    
    
    func applyGradient(colours: [UIColor], startValue : Double, endValue : Double, radious : Int, locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        gradient.startPoint = CGPoint(x: startValue, y: startValue)
        gradient.endPoint = CGPoint(x: endValue, y: endValue)
        gradient.cornerRadius = CGFloat(radious)
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    
    
}
