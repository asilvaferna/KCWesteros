//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Adrián Silva on 29/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

final class EpisodeDetailViewController: UIViewController {

    // MARK: - Properties
    private let episode: Episode

    // MARK: - Outlets
    @IBOutlet weak var releaseDateLabel: UILabel!

    // MARK: - Initializers
    init(episode: Episode) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        releaseDateLabel.text = formatter.string(from: episode.transmissionDate)
        title = episode.title
    }
}
