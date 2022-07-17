//
//  LaunchCollectionViewCell.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 15.09.2021.
//

import UIKit

class LaunchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var upcomingImageView: UIImageView!
    @IBOutlet weak var launchNumberButton: ShadowedButton!
    @IBOutlet weak var patchButton: ShadowedButton!
    @IBOutlet weak var launchNumberLabel: UILabel!
    //@IBOutlet weak var pictureView: UIView!    
    @IBOutlet weak var patchImageView: ImageLoader!
    
    static let cellId = "LaunchCollectionViewCell"
    
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
            //patchImageView.center = pictureView.center
            patchImageView.contentMode = .scaleAspectFit
        }
        nameLabel.text = launch.name
        dateLabel.text = launch.launchDateUTC//utcTime(launch.launchDateUTC)
        upcomingImageView.image = launch.upcoming ?? false ? UIImage(named: "upcomingMark") : UIImage(named: "completedMark")
        launchNumberLabel.text = "#\(launch.flightNumber ?? 0)"
        launchNumberLabel.addShadow()
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
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }
    
    public func configure(_ launch: Launch) {
        if let links = launch.links, let patch = links.patch, let imageUrl = patch.small {
            patchImageView.contentMode = .scaleAspectFit
            patchImageView.loadImageWithUrl(imageUrl)
            //patchImageView.center = pictureView.center
            patchImageView.contentMode = .scaleAspectFit
            patchImageView.setRectInsets(UIEdgeInsets(top: -15, left: -9, bottom: -15, right: -9))
            //patchImageView.addShadow()
        }
        nameLabel.text = launch.name
        //dateLabel.text = utcTime(launch.launchDateUTC)
        if let time = launch.launchDateUTC {
            dateLabel.text = time.utcTime()
        }
        upcomingImageView.image = launch.upcoming ?? false ? UIImage(named: "upcomingMark") : UIImage(named: "completedMark")
        launchNumberLabel.text = "#\(launch.flightNumber ?? 0)"
        launchID = launch.id ?? ""
        rocketID = launch.rocketID ?? ""
    }
    
    private func utcTime(_ time: String?) -> String? {
        guard let timeString = time else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let formattedTime = dateFormatter.date(from: timeString)
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let utcTime = dateFormatter.string(from: formattedTime!)
        return utcTime
    }

}

extension String {
    func utcTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let formattedTime = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let utcTime = dateFormatter.string(from: formattedTime!)
        return utcTime
    }
}
