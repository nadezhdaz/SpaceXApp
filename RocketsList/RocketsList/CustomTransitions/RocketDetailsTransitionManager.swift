//
//  RocketDetailsTransitionManager.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 23.10.2021.
//

import UIKit

class RocketDetailsTransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    private let duration: TimeInterval = 0.15
    private let completionDuration: TimeInterval = 0.24
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? RocketDetailsViewController,
              let toViewController = transitionContext.viewController(forKey: .to) as? RocketsListViewController,
              let currentCell = toViewController.currentCell,
              let headerImageView = toViewController.currentCell?.headerImageView,
              let tabbar = toViewController.tabBarController?.tabBar
        else {
            return
        }
        
        let headerView = fromViewController.headerView
        let stackView = fromViewController.stackView
        //let headerImageView = fromViewController.headerView.headerImageView
        
        let containerView = transitionContext.containerView
        
        let snapshotContentView = UIView()
        snapshotContentView.backgroundColor = headerView.backgroundColor
        snapshotContentView.frame = containerView.convert(headerView.frame, from: fromViewController.view)
        snapshotContentView.layer.cornerRadius = headerView.layer.cornerRadius
        
        let snapshotImageView = ImageLoader()//UIImageView(image: headerImageView.image)
        snapshotImageView.image = headerImageView.image
        snapshotImageView.contentMode = headerImageView.contentMode
        snapshotImageView.frame = containerView.convert(headerImageView.frame, from: headerView)
        
        let titleLabel = UILabel()
        titleLabel.text = headerView.titleLabel.text
        titleLabel.textColor = headerView.titleLabel.textColor
        titleLabel.font = headerView.titleLabel.font
        titleLabel.frame = containerView.convert(headerView.titleLabel.frame, from: headerView)
        
        containerView.addSubview(toViewController.view)
        containerView.addSubview(snapshotContentView)
        snapshotContentView.addSubview(snapshotImageView)
        snapshotContentView.addSubview(titleLabel)
        
        tabbar.alpha = 0.0
        toViewController.view.isHidden = true
        //toViewController.stackView.alpha = 0.0
        containerView.backgroundColor = nil
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            fromViewController.stackView.alpha = 0.0
        }
        
        animator.addCompletion{_ in
                
            toViewController.view.isHidden = false
            snapshotContentView.removeFromSuperview()
            transitionContext.completeTransition(true)
            UIView.animate(withDuration: self.completionDuration, delay: 0, options: [ .transitionCurlDown], animations: {
                snapshotContentView.frame = containerView.convert(toViewController.view.frame, from: toViewController.view)
                snapshotImageView.frame = snapshotContentView.convert(currentCell.headerImageView.frame, from: toViewController.view)
                titleLabel.frame = CGRect(origin: currentCell.titleLabel.frame.origin, size: CGSize(width: toViewController.view.frame.width, height: currentCell.titleLabel.frame.height))
                titleLabel.textColor = currentCell.titleLabel.textColor
                titleLabel.font = currentCell.titleLabel.font
                tabbar.alpha = 1.0
            }, completion: nil)
        }
        
        animator.startAnimation()
        
    }
}
