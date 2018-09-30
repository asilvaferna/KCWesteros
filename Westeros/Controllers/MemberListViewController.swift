//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Adrián Silva on 18/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

final class MemberListViewController: UIViewController {

    // MARK: - Properties
    private var models: [Person]

    // MARK: - Outlets
    @IBOutlet weak var memberTableView: UITableView!

    // MARK: - Initializers
    init(model: [Person]) {
        self.models = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Members"
        memberTableView.delegate = self
        memberTableView.dataSource = self
        memberTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MemberCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(houseDidChange),
                                       name: .houseDidChangeNotification,
                                       object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: kHouseDidChangeNotificationName), object: nil)
    }
}

// MARK: - Private methods
private extension MemberListViewController {
    @objc func houseDidChange(notification: Notification) {
        guard let info = notification.userInfo else { return }
        guard let model = info[kHouseKey] as? House else { return }
        models = model.sortedMembers
        memberTableView.reloadData()
    }
}

// MARK: - TableView Delegate Methods
extension MemberListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - TableView Datasource Methods
extension MemberListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath)
        let member = models[indexPath.row]
        cell.detailTextLabel?.text = member.alias
        cell.textLabel?.text = member.name

        return cell
    }
}
