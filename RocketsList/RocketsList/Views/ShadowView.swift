//
//  ShadowView.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 19.09.2021.
//

import UIKit

class ShadowView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        backgroundColor = .customWhite
        addShadow()
    }

}

extension UIView {
    
    func addShadow() {
        let firstLayer = CAShapeLayer()
        firstLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        firstLayer.fillColor = backgroundColor?.cgColor
        firstLayer.shadowPath = firstLayer.path
        firstLayer.shadowColor = UIColor.white.cgColor
        firstLayer.shadowOpacity = 1.0
        firstLayer.shadowRadius = 3.0
        firstLayer.shadowOffset = CGSize(width: -1, height: -1)
        firstLayer.masksToBounds = false
        
        let secondLayer = CAShapeLayer()
        secondLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        secondLayer.fillColor = backgroundColor?.cgColor
        secondLayer.shadowPath = secondLayer.path
        secondLayer.shadowColor = UIColor.shadowColor.cgColor
        secondLayer.shadowOpacity = 1.0
        secondLayer.shadowRadius = 3.0
        secondLayer.shadowOffset = CGSize(width: 1, height: 1)        
        secondLayer.masksToBounds = false
        
        layer.insertSublayer(firstLayer, at: 0)
        layer.insertSublayer(secondLayer, at: 0)
    }
    
    func addCellShadow() {
        let firstLayer = CAShapeLayer()
        firstLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        firstLayer.fillColor = backgroundColor?.cgColor
        firstLayer.shadowPath = firstLayer.path
        firstLayer.shadowColor = UIColor.white.cgColor
        firstLayer.shadowOpacity = 1.0
        firstLayer.shadowRadius = 3.0
        firstLayer.shadowOffset = CGSize(width: -2, height: -2)
        firstLayer.masksToBounds = false
        
        let secondLayer = CAShapeLayer()
        secondLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        secondLayer.fillColor = backgroundColor?.cgColor
        secondLayer.shadowPath = secondLayer.path
        secondLayer.shadowColor = UIColor.shadowColor.cgColor
        secondLayer.shadowOpacity = 1.0
        secondLayer.shadowRadius = 6.0
        secondLayer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        secondLayer.masksToBounds = false
        
        layer.insertSublayer(firstLayer, at: 0)
        layer.insertSublayer(secondLayer, at: 0)
    }
    
    func clearShadow() {
        layer.sublayers?.removeFirst(2)
    }
}
