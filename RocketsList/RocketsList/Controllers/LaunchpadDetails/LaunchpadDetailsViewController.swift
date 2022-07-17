//
//  LaunchpadDetailsViewController.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 20.09.2021.
//

import UIKit

class LaunchpadDetailsViewController: UIViewController, MainDetailStackViewDelegate, UIScrollViewDelegate, AppButtonsViewDelegate {
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .customWhite
        scroll.delegate = self
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = UIColor.customWhite
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    let SectionHeaderHeight: CGFloat = 65
    
    var launchpad: Launchpad

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    init(launchpad: Launchpad) {
        self.launchpad = launchpad
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let launchpadView = LaunchpadView().loadNib()
        launchpadView.configure(launchpad)
        launchpadView.translatesAutoresizingMaskIntoConstraints = false
        
        let descriptionStack = MainDetailStackView( .description, launchpad: launchpad)
        let overviewStack = MainDetailStackView( .overview, launchpad: launchpad)
        let imagesStack = MainDetailStackView( .images, launchpad: launchpad)
        let locationStack = MainDetailStackView( .location, launchpad: launchpad)
        let materialsStack = MainDetailStackView( .materials, launchpad: launchpad)
        
        imagesStack.zoomingDelegate = self
        materialsStack.appDelegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(launchpadView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(descriptionStack)
        stackView.addArrangedSubview(overviewStack)
        stackView.addArrangedSubview(imagesStack)
        stackView.addArrangedSubview(locationStack)
        stackView.addArrangedSubview(materialsStack)
        
        NSLayoutConstraint.activate([
           scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
           scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
           contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
           contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
           contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
           contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
                
        NSLayoutConstraint.activate([
            launchpadView.topAnchor.constraint(equalTo: contentView.topAnchor),
            launchpadView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            launchpadView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: launchpadView.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        scrollView.contentSize = view.frame.size
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
    
    func pushToRocketsController(rockets identifiers: [String]) {
        let rocketsListController = RocketsListViewController()
        navigationController?.pushViewController(rocketsListController, animated: true)
    }
    
    func pushToLaunchesController(launches identifiers: [String]) {
        let launchesListController = LaunchesViewController()
        navigationController?.pushViewController(launchesListController, animated: true)
    }

}

