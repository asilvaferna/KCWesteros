//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Adrián Silva on 29/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

final class SeasonDetailViewController: UIViewController {

    // MARK: - Properties
    var season: Season
    var episodes: [Episode] {
        didSet {
            guard let tableView = seasonEpisodesTableView else { return }
            tableView.reloadData()
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var seasonReleaseDateLabel: UILabel!
    @IBOutlet weak var seasonEpisodesTableView: UITableView!
    @IBOutlet weak var tableViewTitleLabel: UILabel!

    // MARK: - Initializers
    init(season: Season) {
        self.season = season
        self.episodes = season.sortedEpisodes
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        seasonEpisodesTableView.dataSource = self
        seasonEpisodesTableView.delegate = self
        seasonEpisodesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "EpisodeCell")
        syncModelWithView()

        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
    }
}

// MARK: - Private methods
private extension SeasonDetailViewController {
    func syncModelWithView() {
        guard let _ = seasonReleaseDateLabel else { return }
        title = season.name
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.string(from: season.releaseDate)
        seasonReleaseDateLabel.text = "Release date: \(date)"
        tableViewTitleLabel.text = "Episodes"
    }
}

// MARK: - TableView DataSource methods
extension SeasonDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = seasonEpisodesTableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath)
        let episode = episodes[indexPath.row]
        cell.textLabel?.text = episode.title
        cell.detailTextLabel?.text = "\(episode.transmissionDate)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - TableView delegate methods
extension SeasonDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        seasonEpisodesTableView.deselectRow(at: indexPath, animated: true)
        let episode = episodes[indexPath.row]
        navigationController?.pushViewController(EpisodeDetailViewController(episode: episode), animated: true)
    }
}

// MARK: - SeasonListViewControllerDelegate methods
extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ vc: SeasonListViewController, didSelectSeason season: Season) {
        self.season = season
        episodes = season.sortedEpisodes
        syncModelWithView()
    }
}
