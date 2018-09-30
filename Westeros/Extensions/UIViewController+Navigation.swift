//
//  UIViewController+Navigation.swift
//  Westeros
//
//  Created by Adrián Silva on 16/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
