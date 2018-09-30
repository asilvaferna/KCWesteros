//
//  SplitViewControllerDelegate.swift
//  Westeros
//
//  Created by Adrián Silva on 29/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

final class SplitViewDelegate: NSObject, UISplitViewControllerDelegate {
    func splitViewController(_ svc: UISplitViewController,
                             willShow vc: UIViewController,
                             invalidating barButtonItem: UIBarButtonItem)
    {
        if let detailView = svc.viewControllers.first as? UINavigationController {
            svc.navigationItem.backBarButtonItem = nil
            detailView.topViewController?.navigationItem.leftBarButtonItem = nil
        }
    }

    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool
    {
        guard let navigationController = primaryViewController as? UINavigationController,
            let controller = navigationController.topViewController as? MasterViewController
            else {
                return true
        }

        return controller.collapseDetailViewController
    }
}

protocol MasterViewController {
    var collapseDetailViewController: Bool { get set }
}
