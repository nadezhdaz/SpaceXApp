//
//  RocketView.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 20.09.2021.
//

import UIKit

class RocketView: ShadowView {

    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstLaunchLabel: UILabel!
    @IBOutlet weak var launchCostLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var headerImageView: ImageLoader!
    
    public var rocketID: String = ""
    
    private var heightConstraint = CGFloat(360.0)
    private var widthConstraint = CGFloat(360.0)
    
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
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .customWhite
        layer.cornerRadius = 15
        //addCellShadow()
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: heightConstraint),
            widthAnchor.constraint(equalToConstant: widthConstraint)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(_ rocket: Rocket) {
        if let imageUrl = rocket.flickrImages?.first {
            headerImageView.loadImageWithUrl(imageUrl)
            headerImageView.roundTopCorners(cornerRadius: 15.0)
        }
        titleLabel.text = rocket.rocketName
        firstLaunchLabel.text = rocket.firstLaunch
        launchCostLabel.text = "\(rocket.costPerLaunch ?? 0)$"
        successLabel.text = "\(rocket.successRatePct ?? 0)%"
        rocketID = rocket.rocketID ?? ""
    }
    
    public func loadNib() -> RocketView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! RocketView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = firstLaunchLabel.frame.maxY + 21.0
        heightConstraint = height//headerImageView.frame.height + titleLabel.frame.height
        widthConstraint = headerImageView.frame.width
        addCellShadow()//frame.width
    }

}

extension UIView {
    
    func loadNibUIView() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
