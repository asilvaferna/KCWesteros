//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Adrián Silva on 25/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {

    var releaseDate: Date!

    override func setUp() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        releaseDate = formatter.date(from: "2011/04/17")
    }

    override func tearDown() {

    }

    func testEpisodeExistence() {
        let episode = Episode(title: "Winter Is Coming", transmissionDate: releaseDate, season: nil)
        XCTAssertNotNil(episode)
    }

}
