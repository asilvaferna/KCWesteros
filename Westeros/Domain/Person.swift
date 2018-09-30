//
//  File.swift
//  Westeros
//
//  Created by Adrián Silva on 06/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import Foundation

final class Person {

    // MARK: - Properties
    let name: String
    let house: House
    private let _alias: String?

    var alias: String {
        return _alias ?? ""
    }

    // MARK: - Initialization
    init(name: String, alias: String? = nil, house: House) {
        self.name = name
        self._alias = alias
        self.house = house
        self.house.add(person: self)
    }
}

extension Person {
    var fullName: String {
        return "\(name) \(house.name)"
    }
}

/// Proxy pattern
extension Person {
    var proxyEquality: String {
        return "\(name)\(alias)\(house.name)"
    }
    var proxyComparison: String {
        return fullName.lowercased()
    }
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyEquality == rhs.proxyEquality
    }
}

extension Person: Hashable {
    var hashValue: Int {
        return proxyEquality.hashValue
    }
}

extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyComparison < rhs.proxyComparison
    }
}
