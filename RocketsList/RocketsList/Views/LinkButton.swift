//
//  LinkButton.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 21.09.2021.
//

import UIKit

enum LinkType {
    case web, app
}

class LinkButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        addShadow()
    }
    
    required init(name: String, url: URL, type: LinkType) {
        self.name = name
        self.url = url
        super.init(frame: .zero)
        setupButton()
        setImageWith(type: type)
        setTitle(name, for: .normal)
    }
    
    required init(name: String, identifiers: [String], type: LinkType) {
        self.name = name
        super.init(frame: .zero)
        setupButton()
        setImageWith(type: type)
        setTitle(name, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var name: String
    public var url: URL?
    public var identifiers: [String]?
    
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
    
    func setImageWith(type: LinkType) {
        switch type {
        case .web:
            setImage(UIImage(named: "chain"), for: .normal)
        case .app:
            setImage(UIImage(named: "chevron.right"), for: .normal)
        }
    }
    
    func setupButton() {
        addShadow()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .customWhite
        tintColor = .coral
        semanticContentAttribute = .forceRightToLeft
        //setImage(UIImage(named: "chain"), for: .normal)
        setTitleColor(.coral, for: .normal)
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 15)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
        titleLabel?.font = UIFont(name: "Roboto-Medium", size: 17)
        titleLabel?.textAlignment = .right
    }
    
    func off() {
        isEnabled = false
        alpha = 0.3
        tintColor = .champagne
        addShadow()
    }
    
    func on() {
        isEnabled = true
        alpha = 1.0
        tintColor = .coral
        clearShadow()
    }

}
