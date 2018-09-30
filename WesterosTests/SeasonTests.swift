//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Adrián Silva on 25/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {

    var seasonOneReleaseDate: Date!
    var seasonOne: Season!

    var seasonTwoReleaseDate: Date!
    var seasonTwo: Season!

    override func setUp() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        seasonOneReleaseDate = formatter.date(from: "2011/04/17")
        seasonOne = Season(number: 1, name: "You win or you die", releaseDate: seasonOneReleaseDate)

        seasonTwoReleaseDate = formatter.date(from: "2012/04/01")
        seasonTwo = Season(number: 2, name: "The North Remembers", releaseDate: seasonTwoReleaseDate)

    }

    override func tearDown() {

    }

    func testSeasonExistence() {
        XCTAssertNotNil(seasonOne)
    }

    func testSeasonEquality() {
        XCTAssertEqual(seasonOne, seasonOne)

        let season = Season(number: 1, name: "You win or you die", releaseDate: seasonOneReleaseDate)
        XCTAssertEqual(season, seasonOne)

        XCTAssertNotEqual(seasonTwo, seasonOne)
    }

    func testSeasonHashable() {
        XCTAssertNotNil(seasonOne.hashValue)
    }

    func testSeasonComparable() {
        XCTAssertLessThan(seasonOne, seasonTwo)
        XCTAssertGreaterThan(seasonTwo, seasonOne)
        XCTAssertLessThanOrEqual(seasonOne, seasonOne)
        XCTAssertLessThanOrEqual(seasonOne, seasonTwo)
    }

    func testSeasonCustomStringConvertible() {
        XCTAssertEqual(seasonOne.description, "(1, You win or you die, 2011-04-16 22:00:00 +0000)")
    }
    
}
