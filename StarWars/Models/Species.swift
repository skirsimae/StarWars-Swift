//
//  Species.swift
//  StarWars
//
//  Created by Silva Kirsimae on 12/02/2023.
//

import Foundation
import Differentiator

struct SpeciesResponse: Codable {
    let count: Int
    let next: String
    let previous: String
    let results: [Species]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.results = try container.decode([Species].self, forKey: .results)
        
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

// MARK: - Result
struct Species: Codable {
    let name, classification, designation, averageHeight: String
    let skinColors, hairColors, eyeColors, averageLifespan: String
    let homeworld: String
    let language: String
    let people, films: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, classification, designation
        case averageHeight = "average_height"
        case skinColors = "skin_colors"
        case hairColors = "hair_colors"
        case eyeColors = "eye_colors"
        case averageLifespan = "average_lifespan"
        case homeworld, language, people, films, created, edited, url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.classification = try container.decode(String.self, forKey: .classification)
        self.designation = try container.decode(String.self, forKey: .designation)
        self.averageHeight = try container.decode(String.self, forKey: .averageHeight)
        self.skinColors = try container.decode(String.self, forKey: .skinColors)
        self.hairColors = try container.decode(String.self, forKey: .hairColors)
        self.eyeColors = try container.decode(String.self, forKey: .eyeColors)
        self.averageLifespan = try container.decode(String.self, forKey: .averageLifespan)
        self.language = try container.decode(String.self, forKey: .language)
        self.people = try container.decode([String].self, forKey: .people)
        self.films = try container.decode([String].self, forKey: .films)
        self.created = try container.decode(String.self, forKey: .created)
        self.edited = try container.decode(String.self, forKey: .edited)
        self.url = try container.decode(String.self, forKey: .url)
        
        if let homeworld = try container.decodeIfPresent(String.self, forKey: .homeworld) {
            self.homeworld = homeworld
        } else {
            self.homeworld = ""
        }
    }
}

extension Species: IdentifiableType, Equatable {
    typealias Identity = String
    
    var identity: String {
        return name
    }
}
