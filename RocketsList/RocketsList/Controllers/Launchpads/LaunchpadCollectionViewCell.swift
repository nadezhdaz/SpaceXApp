//
//  LaunchpadCollectionViewCell.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 15.09.2021.
//

import UIKit

class LaunchpadCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var statusButton: ShadowedButton!
    
    
    static let cellId = "LaunchpadCollectionViewCell"
    
    public var launchID: String = ""
    public var rocketID: String = ""
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setups
    
    func setupUI() {
        backgroundColor = .customWhite
        layer.cornerRadius = 15
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(_ launchpad: Launchpad) {
        titleLabel.text = launchpad.name
        locationLabel.text = launchpad.region
        statusButton.setTitle(launchpad.status?.capitalized, for: .normal)
        launchID = launchpad.id ?? ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }

}
