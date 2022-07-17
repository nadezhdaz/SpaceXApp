//
//  ButtonsView.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 19.10.2021.
//

import UIKit

protocol WebButtonsViewDelegate {
    func presentController(url: URL)
}

protocol AppButtonsViewDelegate {
    func pushToRocketsController(rockets identifiers: [String])
    func pushToLaunchesController(launches identifiers: [String])
}

class ButtonsView: UIView {
    
    private let rocketsName = "Rockets"
    private let launchesName = "Launches"
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .clear
        scroll.showsHorizontalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 20.0
        return stackView
    }()
    
    var webDelegate: WebButtonsViewDelegate?
    var appDelegate: AppButtonsViewDelegate?

    // MARK: - Initializers
    
    init(link: Links) {
        super.init(frame: .zero)
        var links: [String : URL] = [:]
        if link.article != nil { links.updateValue(link.article!, forKey: "Article") }
        if link.presskit != nil { links.updateValue(link.presskit!, forKey: "Presskit") }
        if link.webcast != nil { links.updateValue(link.webcast!, forKey: "Webcast") }
        if link.youtube != nil { links.updateValue(link.youtube!, forKey: "Youtube") }
        if link.wikipedia != nil { links.updateValue(link.wikipedia!, forKey: "Wikipedia") }
        
        setupWebStackView(for: links)
        setupView()
    }
    
    init(reddit: Reddit) {
        super.init(frame: .zero)
        var links: [String : URL] = [:]
        if reddit.compaign != nil { links.updateValue(reddit.compaign!, forKey: "Compaign") }
        if reddit.media != nil { links.updateValue(reddit.media!, forKey: "Launch") }
        if reddit.recovery != nil { links.updateValue(reddit.recovery!, forKey: "Recovery") }
        
        setupWebStackView(for: links)
        setupView()
    }
    
    init(wikipedia: URL) {
        super.init(frame: .zero)
        var link: [String : URL] = [:]
        link.updateValue(wikipedia, forKey: "Wikipedia")
        
        setupWebStackView(for: link)
        setupView()
    }
    
    init(rockets: [String]?, launches: [String]?) {
        super.init(frame: .zero)
        setupAppStackView(rockets: rockets, launches: launches)
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.contentSize = stackView.frame.size
    }
    
    private func setupWebStackView(for links: [String : URL]) {
        for link in links {
            let button = LinkButton(name: link.key, url: link.value.absoluteURL, type: .web)
            button.addTarget(self, action: #selector(webButtonPressed(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func setupAppStackView(rockets: [String]?, launches: [String]?) {
        if let rockets = rockets, !(rockets.isEmpty) {
            let button = LinkButton(name: rocketsName, identifiers: rockets, type: .app)
            button.addTarget(self, action: #selector(appButtonPressed(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        if let launches = launches, !(launches.isEmpty) {
            let button = LinkButton(name: launchesName, identifiers: launches, type: .app)
            button.addTarget(self, action: #selector(appButtonPressed(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        let heightConstraint = stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        heightConstraint.priority = UILayoutPriority(rawValue: 250)
        heightConstraint.isActive = true
    }
    
    @objc private func webButtonPressed(_ sender: LinkButton) {
        guard let url = sender.url else { return }
        webDelegate?.presentController(url: url)
    }
    
    @objc private func appButtonPressed(_ sender: LinkButton) {
        guard let identifiers = sender.identifiers else { return }
        if sender.name == rocketsName {
            appDelegate?.pushToRocketsController(rockets: identifiers)
        }
        if sender.name == launchesName {
            appDelegate?.pushToLaunchesController(launches: identifiers)
        }
    }

}
