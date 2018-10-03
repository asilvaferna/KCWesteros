//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Adrián Silva on 30/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    private let person: Person

    init(person: Person) {
        self.person = person
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = person.name
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self,
                                       selector: #selector(houseDidChange),
                                       name: .houseDidChangeNotification,
                                       object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self,
                                                  name: .houseDidChangeNotification,
                                                  object: nil)
    }
}

// MARK: - Private methods
private extension MemberDetailViewController {
    @objc func houseDidChange(notification: Notification) {
        navigationController?.popViewController(animated: true)
    }
}
