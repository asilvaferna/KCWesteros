//
//  HouseDetailController.swift
//  Westeros
//
//  Created by Adrián Silva on 16/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit
import WebKit

final class HouseDetailController: UIViewController {

    // MARK: - Properties
    private var model: House

    // MARK: - Outlets
    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var wordsLabel: UILabel!

    // MARK: - Initializers
    init(model: House) {
        self.model = model
        super.init(nibName: "HouseDetailController", bundle: Bundle.main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        syncModelWithView()
    }
}

// MARK: - Private methods
private extension HouseDetailController {
    func syncModelWithView() {
        sigilImageView.image = model.sigil.image
        wordsLabel.text = model.words
        title = "House \(model.name)"
    }

    func setupUI() {
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(executeSegue))
        let memberButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(navigateToMembers))
        navigationItem.rightBarButtonItems = [wikiButton, memberButton]
    }

    @objc func executeSegue() {
        let wikiWebView = WikiViewController(model: model)
        navigationController?.pushViewController(wikiWebView, animated: true)
    }

    @objc func navigateToMembers() {
        let memberViewController = MemberListViewController(model: model.sortedMembers)
        navigationController?.pushViewController(memberViewController, animated: true)
    }
}

// MARK: - HouseTableViewControllerDelegate methods
extension HouseDetailController: HousesTableViewControllerDelegate {
    func houseTableViewController(_ vc: HousesTableViewController, didSelectHouse house: House) {
        self.model = house
        syncModelWithView()
    }
}
