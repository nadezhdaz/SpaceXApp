//
//  LaunchDetailsViewController.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 20.09.2021.
//

import UIKit

 class LaunchDetailsViewController: UIViewController, MainDetailStackViewDelegate, WebButtonsViewDelegate {
     
     private lazy var launchView: LaunchView = {
         let header = LaunchView()
         header.backgroundColor = .clear
         header.translatesAutoresizingMaskIntoConstraints = false
         return header
     }()
     
     private lazy var scrollView: UIScrollView = {
         let scroll = UIScrollView()
         scroll.backgroundColor = .customWhite
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
     
     var rocket: Rocket?
     var launch: Launch

     override func viewDidLoad() {
         super.viewDidLoad()
         navigationController?.navigationBar.isHidden = false
         navigationController?.setNavigationBarHidden(false, animated: true)
     }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = view.frame.size
    }
     
     init(launch: Launch) {
         self.launch = launch
         super.init(nibName: nil, bundle: nil)
         
         setupRocket()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     func setupViews() {
        let launchView = LaunchView().loadNib()
        //let launchView = LaunchDetailsView()
        launchView.configure(launch)
        launchView.translatesAutoresizingMaskIntoConstraints = false
        guard let rocket = rocket else { return }
        
        let descriptionStack = MainDetailStackView( .description, launch: launch, rocket: rocket)
        let overviewStack = MainDetailStackView( .overview, launch: launch, rocket: rocket)
        let imagesStack = MainDetailStackView( .images, launch: launch, rocket: rocket)
        let rocketStack = MainDetailStackView( .rocketCell, launch: launch, rocket: rocket)
        let materialsStack = MainDetailStackView( .materials, launch: launch, rocket: rocket)
        let redditStack = MainDetailStackView( .reddit, launch: launch, rocket: rocket)
        
        imagesStack.zoomingDelegate = self
        materialsStack.webDelegate = self
        redditStack.webDelegate = self
        
         view.addSubview(scrollView)
         scrollView.addSubview(contentView)
         contentView.addSubview(launchView)
         contentView.addSubview(stackView)
         
         stackView.addArrangedSubview(descriptionStack)
         stackView.addArrangedSubview(overviewStack)
         stackView.addArrangedSubview(imagesStack)
         stackView.addArrangedSubview(rocketStack)
         stackView.addArrangedSubview(materialsStack)
         stackView.addArrangedSubview(redditStack)
         
         NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
         ])
         
         NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
         ])
                 
         NSLayoutConstraint.activate([
            launchView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30.0),
            launchView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            launchView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
         ])
         
         NSLayoutConstraint.activate([
             stackView.topAnchor.constraint(equalTo: launchView.bottomAnchor, constant: 10.0),
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
     
     private func setupRocket() {
         guard let rocketID = launch.rocketID else { return }
         getRocket(rockerID: rocketID, completion: { [weak self] rocket in
             DispatchQueue.main.async {
                self?.rocket = rocket
                self?.setupViews()
             }
         })
     }
     
     private func getRocket(rockerID: String,completion: @escaping (Rocket) -> ()) {
         NetworkService.shared.getRocketRequest(id: rockerID, completion: { result, error  in
             if let result = result {
                 completion(result)
             } else {
                 //AlertController.showError(for: error)
             }
           })
       }
    
    public func presentController(url: URL) {
        let webController = WebViewController(url: url)
        webController.modalPresentationStyle = .fullScreen
        present(webController, animated: true, completion: nil)
    }
    
 }
