//
//  RocketsListViewController.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 12.09.2021.
//

import UIKit

class RocketsListViewController: UIViewController {
    
    private lazy var rocketsCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.dataSource = self
        collection.delegate = self
        collection.register(cellType: RocketCollectionViewCell.self)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private var rockets: [Rocket]?
    
    public var currentCell: RocketCollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        
        setupCollectionView()
        setupRockets()
    }
    
    func setupCollectionView() {
        view.addSubview(rocketsCollectionView)
        
        NSLayoutConstraint.activate([
            rocketsCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            rocketsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rocketsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            rocketsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupRockets() {
        getFeed(completion: { [weak self] feed in
            DispatchQueue.main.async {
                self?.rockets = feed
                self?.rocketsCollectionView.reloadData()
                self?.rocketsCollectionView.layoutIfNeeded()
            }
        })
    }
    
    private func getFeed(completion: @escaping ([Rocket]) -> ()) {
        NetworkService.shared.getRocketsFeedRequest(completion: { result, error  in
            if let result = result {
                completion(result)
            } else {
                //AlertController.showError(for: error)
            }
          })
      }

}

extension RocketsListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let rockets = rockets else { return 0 }
        return rockets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let rockets = rockets else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueCell(of: RocketCollectionViewCell.self, for: indexPath) else { return UICollectionViewCell() }
        let rocket = rockets[indexPath.row]
        cell.configure(rocket)
        return cell
    }
}

extension RocketsListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let rocket = rockets?[indexPath.row] else { return }
        if let cell = collectionView.cellForItem(at: indexPath) as? RocketCollectionViewCell {
            currentCell = cell
        }
        let detailsController = RocketDetailsViewController()
        detailsController.configure(with: rocket)
        detailsController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailsController, animated: true)
    }
}

extension RocketsListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30.0, left: 0, bottom: 30.0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width * 0.91
        let height = width * 0.95
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let width = UIScreen.main.bounds.width * 0.91
        let spacing = UIScreen.main.bounds.width - width
        return spacing
    }
}

extension RocketsListViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return RocketTransitionManager()
        default:
            return RocketDetailsTransitionManager()
        }
    }
}
