//
//  CharacterTests.swift
//  WesterosTests
//
//  Created by Adrián Silva on 06/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import XCTest
@testable import Westeros

class PersonTests: XCTestCase {

    var lannisterHouse: House!
    var lannisterSigil: Sigil!
    var character: Person!
    var ned: Person!
    var starkHouse: House!
    var starkSigil: Sigil!

    override func setUp() {
        lannisterSigil = Sigil(image: UIImage(), description: "A golden lion rampant on a crimson ")
        lannisterHouse = House(name: "Lannister",
                               sigil: lannisterSigil,
                               words: "A Lannister Always Pays His Debts",
                               url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)
        character = Person(name: "Tyrion", alias: "Dwarf", house: lannisterHouse)
        starkSigil = Sigil(image: UIImage(), description: "A wolf")
        starkHouse = House(name: "Stark",
                           sigil: starkSigil,
                           words: "Winter Is Coming",
                           url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)
        ned = Person(name: "Eddard", alias: "Ned", house: starkHouse)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCharacterExistence() {
        XCTAssertNotNil(character)
    }

    func testPersonFullName() {
        XCTAssertEqual(character.fullName, "Tyrion Lannister")
    }

    func testPersonEquality() {
        // 1. Identity
        XCTAssertEqual(character, character)
        // 2. Equality
        let tyrion = Person(name: "Tyrion", alias: "Dwarf", house: lannisterHouse)
        XCTAssertEqual(tyrion, character)
        // 3. Inequality
        XCTAssertNotEqual(ned, tyrion)
    }

    func testPersonComparison() {
        XCTAssertLessThan(ned, character)
    }

}
