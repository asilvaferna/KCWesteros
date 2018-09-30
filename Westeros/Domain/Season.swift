//
//  Season.swift
//  Westeros
//
//  Created by Adrián Silva on 25/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

final class Season {
    let number: Int
    let name: String
    let releaseDate: Date
    private var _episodes: Episodes

    var sortedEpisodes: [Episode] {
        return _episodes.sorted()
    }

    init(number: Int, name: String, releaseDate: Date) {
        self.number = number
        self.name = name
        self.releaseDate = releaseDate
        self._episodes = Episodes()
    }
}

extension Season {
    var count: Int {
        return _episodes.count
    }

    func add(episode: Episode) {
        guard name == episode.season?.name else { return }
        _episodes.insert(episode)
    }

    func add(episodes: Episode...) {
        episodes.forEach { add(episode: $0) }
    }
}

// MARK: - Proxies
extension Season {
    var proxy: String {
        return "\(number)\(name)\(releaseDate)"
    }
}

// MARK: - Equatable
extension Season: Equatable {
    static func == (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxy == rhs.proxy
    }
}

// MARK: - Hashable
extension Season: Hashable {
    var hashValue: Int {
        return proxy.hashValue
    }
}

// MARK: - Comparable
extension Season: Comparable {
    static func < (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxy < rhs.proxy
    }
}

// MARK: - CustomStringConvertible
extension Season: CustomStringConvertible {
    var description: String {
        return "(\(number), \(name), \(releaseDate))"
    }
}




