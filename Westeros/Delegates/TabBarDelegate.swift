//
//  TabBarDelegate.swift
//  Westeros
//
//  Created by Adrián Silva on 29/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

final class TabBarDelegate: NSObject, UITabBarControllerDelegate {

    private let splitViewController: UISplitViewController
    private let seasonDetailViewController: SeasonDetailViewController
    private let houseDetailViewController: HouseDetailController

    init(splitViewController: UISplitViewController,
         houseDetail: HouseDetailController,
         seasonDetail: SeasonDetailViewController)
    {
        self.splitViewController = splitViewController
        self.seasonDetailViewController = seasonDetail
        self.houseDetailViewController = houseDetail
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedDetailViewController = tabBarController.selectedIndex == 0 ? houseDetailViewController : seasonDetailViewController
        // Checks if splitViewController has more than one viewController
        // This comprobation is needed for those devices that doesn't support the splitViewController
        guard splitViewController.viewControllers.count > 1 else { return }
        splitViewController.showDetailViewController(selectedDetailViewController.wrappedInNavigation(), sender: nil)
    }


}

