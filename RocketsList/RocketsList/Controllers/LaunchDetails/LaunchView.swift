//
//  LaunchView.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 21.09.2021.
//

import UIKit

class LaunchView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var upcomingImageView: UIImageView!
    @IBOutlet weak var launchNumberLabel: UILabel!
    @IBOutlet weak var launchNumberButton: ShadowedButton!
    @IBOutlet weak var patchImageView: ImageLoader!
    
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
    
    convenience init(_ launch: Launch) {
        self.init()
        if let links = launch.links, let patch = links.patch, let imageUrl = patch.small {
            patchImageView.contentMode = .scaleAspectFit
            patchImageView.loadImageWithUrl(imageUrl)
            patchImageView.contentMode = .scaleAspectFit
            patchImageView.setRectInsets(UIEdgeInsets(top: -15, left: -9, bottom: -15, right: -9))
        }
        nameLabel.text = launch.name
        if let time = launch.launchDateUTC {
            dateLabel.text = time.utcTime()
        }
        upcomingImageView.image = launch.upcoming ?? false ? UIImage(named: "upcomingMark") : UIImage(named: "completedMark")
        launchNumberLabel.text = "#\(launch.flightNumber ?? 0)"
        launchID = launch.id ?? ""
        rocketID = launch.rocketID ?? ""
    }
    
    // MARK: - Setups
    
    func setupUI() {
        backgroundColor = .customWhite
        layer.cornerRadius = 15
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(_ launch: Launch) {
        if let links = launch.links, let patch = links.patch, let imageUrl = patch.small {
            patchImageView.contentMode = .scaleAspectFit
            patchImageView.loadImageWithUrl(imageUrl)
            patchImageView.contentMode = .scaleAspectFit
            patchImageView.setRectInsets(UIEdgeInsets(top: -15, left: -9, bottom: -15, right: -9))
        }
        nameLabel.text = launch.name
        if let time = launch.launchDateUTC {
            dateLabel.text = time.utcTime()
        }
        upcomingImageView.image = launch.upcoming ?? false ? UIImage(named: "upcomingMark") : UIImage(named: "completedMark")
        launchNumberLabel.text = "#\(launch.flightNumber ?? 0)"
        launchID = launch.id ?? ""
        rocketID = launch.rocketID ?? ""
    }
    
    private func utcTime(_ time: String?) -> String? {
        guard let time = time else { return nil }
        let dateFormatterISO8601 = ISO8601DateFormatter()
        let dateFormatter = DateFormatter()
        dateFormatterISO8601.formatOptions = [ .withInternetDateTime ]
        let formattedTime = dateFormatterISO8601.date(from: time)!
        dateFormatter.dateFormat = "MMM dd, yyyy 'at' h:mm:ss aaa"
        let utcTime = dateFormatter.string(from: formattedTime)
        return utcTime
    }
    
    public func loadNib() -> LaunchView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! LaunchView
    }

}
