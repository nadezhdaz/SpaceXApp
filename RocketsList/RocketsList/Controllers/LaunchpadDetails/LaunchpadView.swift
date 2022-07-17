//
//  LaunchpadView.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 21.10.2021.
//

import UIKit

class LaunchpadView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var statusButton: ShadowedButton!
    
    static let cellId = "LaunchpadCollectionViewCell"
    
    public var launchID: String = ""
    public var rocketID: String = ""
    
    private var heightConstraint = CGFloat(140.0)
    private var widthConstraint = UIScreen.main.bounds.width
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    }
    
    public func configure(_ launchpad: Launchpad) {
        titleLabel.text = launchpad.name
        locationLabel.text = launchpad.region
        statusButton.setTitle(launchpad.status?.capitalized, for: .normal)
        launchID = launchpad.id ?? ""
    }
    
    public func loadNib() -> LaunchpadView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! LaunchpadView
    }

}
