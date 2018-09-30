//
//  House.swift
//  Westeros
//
//  Created by Adrián Silva on 06/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import Foundation

typealias Words = String
typealias Members = Set<Person>

final class House {
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiUrl: URL
    private var _members: Members

    var sortedMembers: [Person] {
        return _members.sorted()
    }

    init(name: String, sigil: Sigil, words: Words, url: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        self._members = Members()
        self.wikiUrl = url
    }
}

extension House {
    var count: Int {
        return _members.count
    }

    func add(person: Person) {
        guard name == person.house.name else { return }
        _members.insert(person)
    }

    func add(persons: Person...) {
        persons.forEach { add(person: $0) }
    }
}

extension House {
    var proxy: String {
        return "\(name)\(words)\(count)"
    }
}

extension House: Equatable {
    static func ==(lhs: House, rhs: House) -> Bool {
        return lhs.proxy == rhs.proxy
    }
}

extension House: Hashable {
    var hashValue: Int {
        return proxy.hashValue
    }
}

extension House: Comparable {
    static func < (lhs: House, rhs: House) -> Bool {
        return lhs.name < rhs.name
    }
}
