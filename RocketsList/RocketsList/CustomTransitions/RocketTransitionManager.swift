//
//  RocketTransitionManager.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 23.10.2021.
//

import UIKit

class RocketTransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration: TimeInterval = 0.24
    private let completionDuration: TimeInterval = 0.15
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? RocketsListViewController,
              let toViewController = transitionContext.viewController(forKey: .to) as? RocketDetailsViewController,
              let currentCell = fromViewController.currentCell,
              let headerImageView = fromViewController.currentCell?.headerImageView,
              let tabbar = fromViewController.tabBarController?.tabBar
        else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        let snapshotContentView = UIView()
        snapshotContentView.backgroundColor = currentCell.backgroundColor
        snapshotContentView.frame = containerView.convert(currentCell.frame, from: fromViewController.view)
        snapshotContentView.layer.cornerRadius = currentCell.layer.cornerRadius
        
        let snapshotImageView = ImageLoader()//UIImageView(image: headerImageView.image)
        snapshotImageView.image = headerImageView.image
        snapshotImageView.contentMode = headerImageView.contentMode
        snapshotImageView.frame = containerView.convert(currentCell.headerImageView.frame, from: currentCell)
        
        let titleLabel = UILabel()
        titleLabel.text = currentCell.titleLabel.text
        titleLabel.textColor = currentCell.titleLabel.textColor
        titleLabel.font = currentCell.titleLabel.font
        titleLabel.frame = containerView.convert(currentCell.titleLabel.frame, from: currentCell)
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapshotContentView)
        snapshotContentView.addSubview(snapshotImageView)
        snapshotContentView.addSubview(titleLabel)
        
        tabbar.isHidden = true
        toViewController.view.isHidden = true
        toViewController.stackView.alpha = 0.0
        containerView.backgroundColor = nil
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            
            snapshotContentView.frame = containerView.convert(toViewController.view.frame, from: toViewController.view)
            snapshotImageView.frame = snapshotContentView.convert(toViewController.headerView.headerImageView.frame, from: toViewController.view)
            titleLabel.frame = CGRect(origin: toViewController.headerView.titleLabel.frame.origin, size: CGSize(width: toViewController.view.frame.width, height: toViewController.headerView.titleLabel.frame.height))
            titleLabel.textColor = toViewController.headerView.titleLabel.textColor
            titleLabel.font = toViewController.headerView.titleLabel.font
        }
        
        animator.addCompletion{_ in
            toViewController.view.isHidden = false
            snapshotContentView.removeFromSuperview()
            transitionContext.completeTransition(true)
            UIView.animate(withDuration: self.completionDuration, delay: 0, options: [ .transitionCurlDown], animations: { toViewController.stackView.alpha = 1.0 }, completion: nil)
        }
        
        animator.startAnimation()
        
    }
}
