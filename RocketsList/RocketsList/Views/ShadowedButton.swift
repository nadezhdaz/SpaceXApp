//
//  ShadowedButton.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 21.09.2021.
//

import UIKit
enum ShadowedButtonType {
    case text, image
}

class ShadowedButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 15
        addShadow()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    public var name: String?
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.point(inside: point, with: event) {
            self.isHighlighted = true
            return self
        }
        return super.hitTest(point, with: event)
    }
    
    func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .customWhite
        tintColor = .cyanProcess
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        setTitleColor(.cyanProcess, for: .normal)
        titleLabel?.font = UIFont(name: "Roboto-Medium", size: 17)
        titleLabel?.textAlignment = .center
    }

}

/*
 class ShadowedButton: UIButton {
     
     override func layoutSubviews() {
         super.layoutSubviews()
         layer.cornerRadius = 10
         addShadow()
     }
     
     required init(name: String?, type: ShadowedButtonType) {
         self.name = name
         super.init(frame: .zero)
         setupButton()
         setTitleWith(type: type)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     public var name: String?
     
     override open var isHighlighted: Bool {
         didSet {
             //setTitleColor(isHighlighted ? .coral : .champagne, for: .normal)
             //tintColor = isHighlighted ? .coral : .champagne
             //isHighlighted ? addShadow() : clearShadow()
         }
     }
     
     override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
         if self.point(inside: point, with: event) {
             self.isHighlighted = true
             return self
         }
         return super.hitTest(point, with: event)
     }
     
     func setTitleWith(type: ShadowedButtonType) {
         switch type {
         case .text:
             setTitle(name, for: .normal)
         case .image:
             setTitle("", for: .normal)
         }
     }
     
     func setupButton() {
         addShadow()
         translatesAutoresizingMaskIntoConstraints = false
         backgroundColor = .white
         tintColor = .cyanProcess
         //setImage(UIImage(named: "chain"), for: .normal)
         setTitleColor(.cyanProcess, for: .normal)
         titleLabel?.font = UIFont(name: "Roboto-Medium", size: 17)
         titleLabel?.textAlignment = .right
     }

 }


 */
