//
//  LaunchpadsViewController.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 12.09.2021.
//

import UIKit

class LaunchpadsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    private lazy var launchpadsCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.dataSource = self
        collection.delegate = self
        collection.register(cellType: LaunchpadCollectionViewCell.self)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width * 0.91
        let height = width * 0.37
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = UIScreen.main.bounds.width - width
        layout.sectionInset = UIEdgeInsets(top: 30.0, left: 0, bottom: 30.0, right: 0)
        collection.collectionViewLayout = layout
        return collection
    }()
    
    private var launchpads: [Launchpad]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupLaunchpads()
    }
    
    func setupCollectionView() {
        view.addSubview(launchpadsCollectionView)
        
        NSLayoutConstraint.activate([
            launchpadsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            launchpadsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            launchpadsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            launchpadsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let launchpads = launchpads else { return 0 }
        return launchpads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let launchpads = launchpads else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueCell(of: LaunchpadCollectionViewCell.self, for: indexPath) else { return UICollectionViewCell() }
        let launchpad = launchpads[indexPath.row]
        cell.configure(launchpad)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let launchpad = launchpads?[indexPath.row] else { return }
        let detailsController = LaunchpadDetailsViewController(launchpad: launchpad)
        detailsController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailsController, animated: true)
    }
    
    private func setupLaunchpads() {
        getFeed(completion: { [weak self] feed in
            DispatchQueue.main.async {
                self?.launchpads = feed
                self?.launchpadsCollectionView.reloadData()
                self?.launchpadsCollectionView.layoutIfNeeded()
            }
        })
    }
    
    private func getFeed(completion: @escaping ([Launchpad]) -> ()) {
        NetworkService.shared.getLaunchpadsFeedRequest(completion: { result, error  in
            if let result = result {
                completion(result)
            } else {
                //AlertController.showError(for: error)
            }
          })
      }

}
