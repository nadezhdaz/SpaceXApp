//
//  DetailStackView.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 15.09.2021.
//

import UIKit

class DetailStackView: UIStackView {
    
    // MARK: - Properties

    public let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Bold", size: 14.0) ?? .systemFont(ofSize: 14.0)
        label.textColor = .smokyBlack
        label.textAlignment = .left
        return label
    }()
    
    public let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Bold", size: 14.0) ?? .systemFont(ofSize: 14.0)
        label.textColor = .slateGray
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Initializers
    
    init(title: String, info: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.infoLabel.text = info
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    func setupUI() {
        backgroundColor = .clear
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .leading
        spacing = 5
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        setupLabels()
    }
    
    func setupLabels() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(infoLabel)
    }
    
    public func setupInfo(title: String, info: String) {
        self.titleLabel.text = title
        self.infoLabel.text = info
    }

}
