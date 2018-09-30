//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Adrián Silva on 29/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

protocol SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season)
}

final class SeasonListViewController: UITableViewController, MasterViewController {

    // MARK: - Properties
    private let models: [Season]

    var delegate: SeasonListViewControllerDelegate?

    var collapseDetailViewController: Bool

    // MARK: - Initializers
    init(model: [Season]) {
        self.models = model
        self.collapseDetailViewController = true
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SeasonCell")
        title = "Seasons"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - TableView datasource methods
extension SeasonListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeasonCell", for: indexPath)
        let season = models[indexPath.row]
        cell.textLabel?.text = season.name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - TableView delegate methods
extension SeasonListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        collapseDetailViewController = false
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.row]
        guard splitViewController?.viewControllers.count == 1 else {
            delegate?.seasonListViewController(self, didSelectSeason: model)
            return
        }
        navigationController?.pushViewController(SeasonDetailViewController(season: model), animated: true)
    }
}
