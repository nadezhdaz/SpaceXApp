//
//  RocketCollectionViewCell.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 14.09.2021.
//

import UIKit

class RocketCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstLaunchLabel: UILabel!    
    @IBOutlet weak var launchCostLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var headerImageView: ImageLoader!
    
    @IBOutlet weak var firstLaunchHeaderLabel: UILabel!
    @IBOutlet weak var launchCostHeaderLabel: UILabel!
    @IBOutlet weak var successHeaderLabel: UILabel!
    
    static let cellId = "RocketCollectionViewCell"
    
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
    
    public func configure(_ rocket: Rocket) {
        if let imageUrl = rocket.flickrImages?.first {
            headerImageView.loadImageWithUrl(imageUrl)
        }
        titleLabel.text = rocket.rocketName
        firstLaunchLabel.text = rocket.firstLaunch
        launchCostLabel.text = "\(rocket.costPerLaunch ?? 0)$"
        successLabel.text = "\(rocket.successRatePct ?? 0)%"
        rocketID = rocket.rocketID ?? ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }

}
