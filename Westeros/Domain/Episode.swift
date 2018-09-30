//
//  Episode.swift
//  Westeros
//
//  Created by Adrián Silva on 25/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import Foundation

final class Episode {
    let title: String
    let transmissionDate: Date
    weak var season: Season?

    init(title: String, transmissionDate: Date, season: Season?) {
        self.title = title
        self.transmissionDate = transmissionDate
        self.season = season
    }
}

extension Episode {
    var proxy: String {
        return "\(title)\(transmissionDate)\(String(describing: season))"
    }
}

extension Episode: Hashable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxy == rhs.proxy
    }

    var hashValue: Int {
        return proxy.hashValue
    }
}

extension Episode: Comparable {
    static func < (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxy < rhs.proxy
    }
}

