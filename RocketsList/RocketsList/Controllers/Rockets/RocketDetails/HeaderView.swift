//
//  HeaderView.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 15.09.2021.
//

import UIKit

class HeaderView: UIView {
    
    public lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Vector"), for: .normal)        
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var headerImageView: ImageLoader = {
        let imageView = ImageLoader()
        imageView.contentMode = .top
        imageView.layer.cornerRadius = 4.0
        //imageView.layer.borderWidth = 1.0
        //imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Bold", size: 48.0) ?? .systemFont(ofSize: 48.0)
        label.textColor = .customWhite
        label.text = label.text?.capitalized
        label.textAlignment = .left
        return label
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5, 1.0]
        return gradient
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = headerImageView.bounds
        headerImageView.layer.addSublayer(gradientLayer)
        addShadow()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = headerImageView.bounds
        headerImageView.layer.addSublayer(gradientLayer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.clear
        
        addSubview(headerImageView)
        addSubview(titleLabel)
        addSubview(backButton)
        
        translatesAutoresizingMaskIntoConstraints = false
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: 50.0),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0)
        ])
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: topAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerImageView.heightAnchor.constraint(equalTo: headerImageView.widthAnchor, multiplier: 414.0/383.0)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20.0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0)
        ])
        
        
    }
    
}

