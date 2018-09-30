//
//  AppDelegate.swift
//  Westeros
//
//  Created by Adrián Silva on 06/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var splitDelegate: SplitViewDelegate?

    var tabBarDelegate: TabBarDelegate?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .gray

        let houses = Repository.local.houses
        let seasons = Repository.local.seasons

        let seasonListViewController = SeasonListViewController(model: seasons)
        let seasonDetailViewController = SeasonDetailViewController(season: seasons.first!)
        seasonListViewController.delegate = seasonDetailViewController
        let houseListViewController = HousesTableViewController(model: houses)
        let lastHouseSelected = houseListViewController.lastSelectedHouse()
        let houseDetailViewController = HouseDetailController(model: lastHouseSelected)
        houseListViewController.delegate = houseDetailViewController

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            houseListViewController.wrappedInNavigation(),
            seasonListViewController.wrappedInNavigation()
        ]
        splitDelegate = SplitViewDelegate()
        let splitViewController = UISplitViewController()
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.delegate = splitDelegate
        splitViewController.viewControllers = [
            tabBarController,
            houseDetailViewController.wrappedInNavigation(),
            seasonDetailViewController.wrappedInNavigation()
        ]
        tabBarDelegate = TabBarDelegate(splitViewController: splitViewController, houseDetail: houseDetailViewController, seasonDetail: seasonDetailViewController)
        tabBarController.delegate = tabBarDelegate!

        window?.rootViewController = splitViewController
        
        return true
    }

}

