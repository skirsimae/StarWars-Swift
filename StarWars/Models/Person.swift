//
//  Person.swift
//  StarWars
//
//  Created by Silva Kirsimae on 12/02/2023.
//

import Foundation
import Differentiator

struct PeopleResponse: Codable {
    let count: Int
    let next: String
    let previous: String
    let results: [Person]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.results = try container.decode([Person].self, forKey: .results)
        
        if let next = try container.decodeIfPresent(String.self, forKey: .next) {
            self.next = next
        } else {
            self.next = ""
        }
        
        if let previous = try container.decodeIfPresent(String.self, forKey: .previous) {
            self.previous = previous
        } else {
            self.previous = ""
        }
    }
}

struct Person: Codable {
    let name, height, mass, hairColor: String
    let skinColor, eyeColor, birthYear, gender: String
    let homeworld: String
    let films: [String]
    let species: [String]
    let vehicles, starships: [String]
    let created, edited: String
    let url: String
    

    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender, homeworld, films, species, vehicles, starships, created, edited, url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.height = try container.decode(String.self, forKey: .height)
        self.mass = try container.decode(String.self, forKey: .mass)
        self.hairColor = try container.decode(String.self, forKey: .hairColor)
        self.skinColor = try container.decode(String.self, forKey: .skinColor)
        self.eyeColor = try container.decode(String.self, forKey: .eyeColor)
        self.birthYear = try container.decode(String.self, forKey: .birthYear)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.homeworld = try container.decode(String.self, forKey: .homeworld)
        self.films = try container.decode([String].self, forKey: .films)
        self.vehicles = try container.decode([String].self, forKey: .vehicles)
        self.starships = try container.decode([String].self, forKey: .starships)
        self.created = try container.decode(String.self, forKey: .created)
        self.edited = try container.decode(String.self, forKey: .edited)
        self.url = try container.decode(String.self, forKey: .url)
        
        if let species = try container.decodeIfPresent([String].self, forKey: .species) {
            self.species = species
        } else {
            self.species = [""]
        }
    }
}

extension Person: IdentifiableType, Equatable {
    typealias Identity = String
    
    var identity: String {
        return name
    }
}
