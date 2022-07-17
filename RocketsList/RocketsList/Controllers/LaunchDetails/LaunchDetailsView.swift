//
//  LaunchDetailsView.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 19.10.2021.
//

import UIKit

class LaunchDetailsView: UIView {

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Bold", size: 24.0) ?? .systemFont(ofSize: 24.0)
        label.textColor = .black
        //label.text = label.text?.capitalized
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Medium", size: 17) ?? .systemFont(ofSize: 17.0)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var upcomingImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var launchNumberShadowView: ShadowView = {
        let view = ShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var launchNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Medium", size: 17) ?? .systemFont(ofSize: 48.0)
        label.textColor = .cyanProcess
        label.textAlignment = .center
        return label
    }()
    
    private lazy var patchImageShadowView: ShadowView = {
        let view = ShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var patchImageView: ImageLoader = {
        let image = ImageLoader()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
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
    
    // MARK: - Setups
    
    func setupUI() {
        backgroundColor = .customWhite
        layer.cornerRadius = 15
        
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(upcomingImageView)
        addSubview(launchNumberShadowView)
        addSubview(launchNumberLabel)
        addSubview(patchImageShadowView)
        addSubview(patchImageView)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20.0),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -5.0),
            dateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            upcomingImageView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            upcomingImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 17.0),
            
            launchNumberShadowView.centerYAnchor.constraint(equalTo: upcomingImageView.centerYAnchor),
            launchNumberShadowView.leadingAnchor.constraint(equalTo: upcomingImageView.trailingAnchor, constant: -10.0),
            
            launchNumberLabel.topAnchor.constraint(equalTo: launchNumberShadowView.topAnchor, constant: -5.0),
            launchNumberLabel.leadingAnchor.constraint(equalTo: launchNumberShadowView.leadingAnchor, constant: -10.0),
            launchNumberLabel.bottomAnchor.constraint(equalTo: launchNumberShadowView.bottomAnchor, constant: 5.0),
            launchNumberLabel.trailingAnchor.constraint(equalTo: launchNumberShadowView.trailingAnchor, constant: 10.0),
            
            //launchNumberLabel.centerYAnchor.constraint(equalTo: launchNumberShadowView.centerYAnchor),
            //launchNumberLabel.centerXAnchor.constraint(equalTo: launchNumberShadowView.centerXAnchor),
            
            patchImageShadowView.centerYAnchor.constraint(equalTo: centerYAnchor),
            patchImageShadowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20.0),
            
            patchImageView.topAnchor.constraint(equalTo: patchImageShadowView.topAnchor, constant: -15.0),
            patchImageView.leadingAnchor.constraint(equalTo: patchImageShadowView.leadingAnchor, constant: -9.5),
            patchImageView.bottomAnchor.constraint(equalTo: patchImageShadowView.bottomAnchor, constant: 15.0),
            patchImageView.trailingAnchor.constraint(equalTo: patchImageShadowView.trailingAnchor, constant: 9.5),
        ])
    }

}
