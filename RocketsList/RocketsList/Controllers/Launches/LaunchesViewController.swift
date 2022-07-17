//
//  LaunchesViewController.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 12.09.2021.
//

import UIKit

class LaunchesViewController: UIViewController {
    
    private lazy var launchesCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.dataSource = self
        collection.delegate = self
        collection.register(cellType: LaunchCollectionViewCell.self)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private var launches: [Launch]?
    private var rocket: Rocket?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupLaunches()
    }
    
    func setupCollectionView() {
        view.addSubview(launchesCollectionView)
        
        NSLayoutConstraint.activate([
            launchesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            launchesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            launchesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            launchesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupLaunches() {
        getFeed(completion: { [weak self] feed in
            DispatchQueue.main.async {
                self?.launches = feed
                self?.launchesCollectionView.reloadData()
                self?.launchesCollectionView.layoutIfNeeded()
            }
        })
    }
    
    private func getFeed(completion: @escaping ([Launch]) -> ()) {
        NetworkService.shared.getLaunchesFeedRequest(completion: { result, error  in
            if let result = result {
                completion(result)
            } else {
                //AlertController.showError(for: error)
            }
        })
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
    
}

extension LaunchesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let launches = launches else { return 0 }
        return launches.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let launches = launches else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueCell(of: LaunchCollectionViewCell.self, for: indexPath) else { return UICollectionViewCell() }
        let launch = launches[indexPath.row]
        cell.configure(launch)
        return cell
    }
}

extension LaunchesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let launch = launches?[indexPath.row] else { return }
        let detailsController = LaunchDetailsViewController(launch: launch)
        detailsController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailsController, animated: true)
    }
}

extension LaunchesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30.0, left: 0, bottom: 30.0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width * 0.91
        let height = width * 0.384
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let width = UIScreen.main.bounds.width * 0.91
        let spacing = UIScreen.main.bounds.width - width
        return spacing
    }
}
