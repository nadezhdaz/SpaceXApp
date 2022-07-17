//
//  TabBarViewController.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 12.09.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .queenBlue
        createTabBarController()
        self.delegate = self
    }
    
    func createTabBarController() {
        let rocketsVc = RocketsListViewController()
        rocketsVc.tabBarItem = UITabBarItem(title: "Rockets", image: UIImage(named: "rocket"), tag: 0)
        
        let launchesVc = LaunchesViewController()
        launchesVc.tabBarItem = UITabBarItem(title: "Launches", image: UIImage(named: "adjustment"), tag: 1)
        
        let launchpadsVc = LaunchpadsViewController()
        launchpadsVc.tabBarItem = UITabBarItem(title: "Launchpads", image: UIImage(named: "lego"), tag: 2)
        
        let controllerArray = [rocketsVc, launchesVc, launchpadsVc]
        viewControllers = controllerArray.map{ UINavigationController(rootViewController: $0) }
        
        tabBar.backgroundColor = .queenBlue
        tabBar.barTintColor = .queenBlue
        tabBar.tintColor = .coral
    }

}

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return TabBarTransitionManager(viewControllers: tabBarController.viewControllers)
    }
}
