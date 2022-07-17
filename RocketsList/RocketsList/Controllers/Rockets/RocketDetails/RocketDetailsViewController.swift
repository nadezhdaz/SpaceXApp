//
//  RocketDetailsViewController.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 15.09.2021.
//

import UIKit

class RocketDetailsViewController: UIViewController, MainDetailStackViewDelegate, WebButtonsViewDelegate {
    
    public lazy var headerView: HeaderView = {
        let header = HeaderView()
        header.backgroundColor = .clear
        header.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .customWhite
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    public lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    let SectionHeaderHeight: CGFloat = 65
    
    var rocket: Rocket?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        setupViews()
    }
    
    public func configure(with rocketInstance: Rocket) {
        rocket = rocketInstance
        if let imageUrl = rocket?.flickrImages?.first {
            headerView.headerImageView.loadImageWithUrl(imageUrl)
            headerView.titleLabel.text = rocket?.rocketName
        }
    }
    
    func setupViews() {
        view.insetsLayoutMarginsFromSafeArea = false
        scrollView.contentInsetAdjustmentBehavior = .never
        
        guard let rocketInstance = rocket else { return }
        
        let descriptionStack = MainDetailStackView( .description, rocket: rocketInstance)
        let overviewStack = MainDetailStackView( .overview, rocket: rocketInstance)
        let imagesStack = MainDetailStackView( .images, rocket: rocketInstance)
        let enginesStack = MainDetailStackView( .engines, rocket: rocketInstance)
        let firstStageStack = MainDetailStackView( .firstStage, rocket: rocketInstance)
        let secondStageStack = MainDetailStackView( .secondStage, rocket: rocketInstance)
        let landingLegsStack = MainDetailStackView( .landingLegs, rocket: rocketInstance)
        let materialsStack = MainDetailStackView( .materials, rocket: rocketInstance)
        
        imagesStack.zoomingDelegate = self
        materialsStack.webDelegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(descriptionStack)
        stackView.addArrangedSubview(overviewStack)
        stackView.addArrangedSubview(imagesStack)
        stackView.addArrangedSubview(enginesStack)
        stackView.addArrangedSubview(firstStageStack)
        stackView.addArrangedSubview(secondStageStack)
        stackView.addArrangedSubview(landingLegsStack)
        stackView.addArrangedSubview(materialsStack)
        
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor, constant: -20.0),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20.0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    @objc func backButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func presentZoomingController(url: URL) {
        let topViewController = topMostController()
        let zoomingController = ZoomingViewController(url: url)
        zoomingController.modalPresentationStyle = .fullScreen
        topViewController.present(zoomingController, animated: true, completion: nil)
    }
    
    func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
            
        }
        return topController
    }
    
    public func presentController(url: URL) {
        let webController = WebViewController(url: url)
        webController.modalPresentationStyle = .fullScreen
        present(webController, animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
}
