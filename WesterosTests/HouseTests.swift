//
//  HouseTests.swift
//  WesterosTests
//
//  Created by Adrián Silva on 06/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {

    var starkSigil: Sigil!
    var lannisterSigil: Sigil!

    var starkHouse: House!
    var lannisterHouse: House!

    var robb: Person!
    var arya: Person!
    var tyrion: Person!

    override func setUp() {
        starkSigil = Sigil(image: UIImage(), description: "A grey direwolf on a white field")
        lannisterSigil = Sigil(image: UIImage(), description: "A golden lion rampant on a crimson field")
        starkHouse = House(name: "Stark",
                           sigil: starkSigil,
                           words: "Winter Is Coming",
                           url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        lannisterHouse = House(name: "Lannister",
                               sigil: lannisterSigil,
                               words: "A Lannister Always Pays His Debts",
                               url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)

        robb = Person(name: "Robb", alias: "Young wolf", house: starkHouse)
        arya = Person(name: "Arya", house: starkHouse)
        tyrion = Person(name: "Tyrion", alias: "Dwarf", house: lannisterHouse)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHouseExistence() {
        let starkSigil = Sigil(image: UIImage(), description: "Wolf")
        let stark = House(name: "Stark",
                          sigil: starkSigil,
                          words: "Winter Is Coming",
                          url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)

        XCTAssertNotNil(stark)
    }

    func testSigilExistence() {
        let starkSigil = Sigil(image: UIImage(), description: "Wolf")

        XCTAssertNotNil(starkSigil)
    }

    func testHouse_AddPersons_ReturnsTheCorrectCountOfPersons() {
        XCTAssertEqual(starkHouse.count, 2)
        starkHouse.add(person: robb)
        starkHouse.add(person: robb)
        starkHouse.add(person: robb)
        starkHouse.add(person: robb)
        XCTAssertEqual(starkHouse.count, 2)
        starkHouse.add(person: arya)
        XCTAssertEqual(starkHouse.count, 2)

        XCTAssertEqual(lannisterHouse.count, 1)
        lannisterHouse.add(person: tyrion)
        XCTAssertEqual(lannisterHouse.count, 1)
        starkHouse.add(person: tyrion)
        XCTAssertEqual(starkHouse.count, 2)
    }

    func testHouse_AddPersonsAtATime_ReturnsTheCorrectCountOfPersons() {
        XCTAssertEqual(starkHouse.count, 2)
    }

    func testHouseEquality() {
        // 1. Identity
        XCTAssertEqual(starkHouse, starkHouse)
        // 2. Equality
        let jinxed = House(name: "Stark",
                           sigil: starkSigil,
                           words: "Winter Is Coming",
                           url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        // When we create a Person object, this object is added to its house
        // In this situation jinxed is not equal to Stark, because Stark contains 2 Persons and jinxed none
        XCTAssertNotEqual(starkHouse, jinxed)
        // 3. Inequality
        XCTAssertNotEqual(lannisterHouse, starkHouse)
    }

    func testHouseHashable() {
        XCTAssertNotNil(starkHouse.hashValue)
    }

    func testHouseComparison() {
        XCTAssertLessThan(lannisterHouse, starkHouse)
        XCTAssertGreaterThan(starkHouse, lannisterHouse)
        XCTAssertLessThanOrEqual(lannisterHouse, lannisterHouse)
        XCTAssertLessThanOrEqual(lannisterHouse, starkHouse)
    }

    func testHouseMembersSorted() {

    }
}
