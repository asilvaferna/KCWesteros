//
//  HousesTableViewController.swift
//  Westeros
//
//  Created by Adrián Silva on 17/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

protocol HousesTableViewControllerDelegate {
    func houseTableViewController(_ vc: HousesTableViewController, didSelectHouse house: House)
}

final class HousesTableViewController: UITableViewController, MasterViewController {
    // MARK: - Properties
    private let models: [House]

    var delegate: HousesTableViewControllerDelegate?

     var collapseDetailViewController: Bool

    // MARK: - Initializers
    init(model: [House]) {
        self.models = model
        self.collapseDetailViewController = true
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        title = "Houses"

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Table view data source methods
extension HousesTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let house = models[indexPath.row]
        cell.textLabel?.text = house.name
        cell.imageView?.image = house.sigil.image
        cell.accessoryType = .disclosureIndicator

        return cell
    }
}

// MARK: - Table view delegate methods
extension HousesTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        collapseDetailViewController = false
        tableView.deselectRow(at: indexPath, animated: true)

        let model = house(at: indexPath.row)

        saveLastSelectedHouse(withIndex: indexPath.row)

        guard splitViewController?.viewControllers.count == 1 else {
            let notificationCenter = NotificationCenter.default
            notificationCenter.post(name: .houseDidChangeNotification,
                                    object: nil,
                                    userInfo: ["House": model])
            delegate?.houseTableViewController(self, didSelectHouse: model)
            return
        }
        navigationController?.pushViewController(HouseDetailController(model: model), animated: true)
    }
}

// MARK: - Internal methods
internal extension HousesTableViewController {
    func lastSelectedHouse() -> House {
        let index = UserDefaults.standard.integer(forKey: kLastHouse)
        return house(at: index)
    }
}

// MARK: - Private methods
private extension HousesTableViewController {
    func saveLastSelectedHouse(withIndex index: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(index, forKey: kLastHouse)
        userDefaults.synchronize()
    }

    func house(at index: Int) -> House {
        return models[index]
    }
}
