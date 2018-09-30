//
//  Repository.swift
//  Westeros
//
//  Created by Adrián Silva on 16/09/2018.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

final class Repository {

    static let local = LocalFactory()
}

protocol HouseFactory {
    typealias HouseFilter = (House) -> Bool
    var houses: [House] { get }

    func house(named name: String) -> House?
    func search(house: House) -> Bool
    func houses(filteredBy filter: HouseFilter) -> [House]
}

protocol SeasonFactory {
    typealias SeasonFilter = (Season) -> Bool
    var seasons: [Season] { get }

    func seasons(filteredBy filter: SeasonFilter) -> [Season]
}

final class LocalFactory: HouseFactory {
    func houses(filteredBy filter: HouseFilter) -> [House] {
        return houses.filter(filter)
    }

    func search(house: House) -> Bool {
        return houses.contains(house)
    }

    func house(named name: String) -> House? {
        return houses.first { $0.name.uppercased() == name.uppercased() }
    }

    func house(named name: HouseName) -> House? {
        return houses.first { $0.name.uppercased() == name.rawValue.uppercased() }
    }

    var houses: [House] {
        let starkSigil = Sigil(image: UIImage(named: "codeIsComing")!,
                               description: "A grey direwolf on a white field")
        let starkHouse = House(name: "Stark",
                               sigil: starkSigil,
                               words: "Winter Is Coming",
                               url: URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!)

        let targaryenSigil = Sigil(image: UIImage(named: "targaryenSmall")!,
                                   description: "A red three-headed dragon, on a black field")
        let targaryenHouse = House(name: "Targaryen",
                                   sigil: targaryenSigil,
                                   words: "Fire and Blood",
                                   url: URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!)

        let lannisterSigil = Sigil(image: UIImage(named: "lannister")!,
                                   description: "A golden lion rampant on a crimson ")
        let lannisterHouse = House(name: "Lannister",
                                   sigil: lannisterSigil,
                                   words: "A Lannister Always Pays His Debts",
                                   url: URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!)

        let robb = Person(name: "Robb", alias: "Young wolf", house: starkHouse)
        let arya = Person(name: "Arya", house: starkHouse)
        let tyrion = Person(name: "Tyrion", alias: "Dwarf", house: lannisterHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaime = Person(name: "Jaime", alias: "Kingslayer", house: lannisterHouse)
        let danaerys = Person(name: "Danaerys", alias: "Mother of Dragons", house: targaryenHouse)
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
}

extension LocalFactory: SeasonFactory {
    func seasons(filteredBy filter: (Season) -> Bool) -> [Season] {
        return seasons.filter(filter)
    }
    
    var seasons: [Season] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let seasonOne = Season(number: 1, name: "Season 1", releaseDate: formatter.date(from: "2011/04/17")!)
        let seasonTwo = Season(number: 2, name: "Season 2", releaseDate: formatter.date(from: "2012/04/01")!)
        let seasonThree = Season(number: 3, name: "Season 3", releaseDate: formatter.date(from: "2013/03/31")!)
        let seasonFour = Season(number: 4, name: "Season 4", releaseDate: formatter.date(from: "2014/04/06")!)
        let seasonFive = Season(number: 5, name: "Season 5", releaseDate: formatter.date(from: "2015/04/12")!)
        let seasonSix = Season(number: 6, name: "Season 6", releaseDate: formatter.date(from: "2016/04/24")!)
        let seasonSeven = Season(number: 7, name: "Season 7", releaseDate: formatter.date(from: "2017/07/16")!)

        let seasonOneEpisodeOne = Episode(title: "Winter Is Coming", transmissionDate: formatter.date(from: "2011/04/17")!, season: seasonOne)
        let seasonOneEpisodeTwo = Episode(title: "The Kingsroad", transmissionDate: formatter.date(from: "2011/04/24")!, season: seasonOne)
        let seasonTwoEpisodeOne = Episode(title: "Valar Morghulis", transmissionDate: formatter.date(from: "2012/04/01")!, season: seasonTwo)
        let seasonTwoEpisodeTwo = Episode(title: "The Night Lands", transmissionDate: formatter.date(from: "2012/04/08")!, season: seasonTwo)
        let seasonThreeEpisodeOne = Episode(title: "Valar Dohaeris", transmissionDate: formatter.date(from: "2013/03/31")!, season: seasonThree)
        let seasonThreeEpisodeTwo = Episode(title: "Dark Wings, Dark Words", transmissionDate: formatter.date(from: "2013/04/07")!, season: seasonThree)
        let seasonFourEpisodeOne = Episode(title: "Two Swords", transmissionDate: formatter.date(from: "2014/04/06")!, season: seasonFour)
        let seasonFourEpisodeTwo = Episode(title: "The Lion and the Rose", transmissionDate: formatter.date(from: "2014/04/13")!, season: seasonFour)
        let seasonFiveEpisodeOne = Episode(title: "The Wars to Come", transmissionDate: formatter.date(from: "2015/04/12")!, season: seasonFive)
        let seasonFiveEpisodeTwo = Episode(title: "The House of Black and White", transmissionDate: formatter.date(from: "2015/04/19")!, season: seasonFive)
        let seasonSixEpisodeOne = Episode(title: "The Red Woman", transmissionDate: formatter.date(from: "2016/04/24")!, season: seasonSix)
        let seasonSixEpisodeTwo = Episode(title: "Home", transmissionDate: formatter.date(from: "2016/05/01")!, season: seasonSix)
        let seasonSevenEpisodeOne = Episode(title: "Dragonstone", transmissionDate: formatter.date(from: "2017/07/16")!, season: seasonSeven)
        let seasonSevenEpisodeTwo = Episode(title: "Stormborn", transmissionDate: formatter.date(from: "2017/07/23")!, season: seasonSeven)

        seasonOne.add(episodes: seasonOneEpisodeOne, seasonOneEpisodeTwo)
        seasonTwo.add(episodes: seasonTwoEpisodeOne, seasonTwoEpisodeTwo)
        seasonThree.add(episodes: seasonThreeEpisodeOne, seasonThreeEpisodeTwo)
        seasonFour.add(episodes: seasonFourEpisodeOne, seasonFourEpisodeTwo)
        seasonFive.add(episodes: seasonFiveEpisodeOne, seasonFiveEpisodeTwo)
        seasonSix.add(episodes: seasonSixEpisodeOne, seasonSixEpisodeTwo)
        seasonSeven.add(episodes: seasonSevenEpisodeOne, seasonSevenEpisodeTwo)
        return [seasonOne, seasonTwo, seasonThree, seasonFour, seasonFive, seasonSix, seasonSeven]
    }
}
