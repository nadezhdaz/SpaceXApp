//
//  ImageCollectionViewCell.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 16.09.2021.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    var imageView: ImageLoader = {
        let imageView = ImageLoader()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .customWhite
        
        //layer.cornerRadius = 4.0
        //layer.borderWidth = 1.0
        //layer.borderColor = UIColor.white.cgColor
        
        addSubview(imageView)
        
        //layer.addSublayer(innerShapeLayer)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 3.0),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3.0),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3.0),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3.0)
        ])
        
    }
    
    func configureImageFrom(_ url: URL) {
        imageView.loadImageWithUrl(url)
    }
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupView()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.layer.cornerRadius = 7.0
        layer.cornerRadius = 10.0
        addShadow()
    }
}
