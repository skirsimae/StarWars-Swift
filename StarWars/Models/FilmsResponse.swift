//
//  Films.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import Foundation

struct FilmsResponse: Codable {
    let count: Int
    let next, previous: Int
    let results: [Film]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.results = try container.decode([Film].self, forKey: .results)
        
        if let next = try container.decodeIfPresent(Int.self, forKey: .next) {
            self.next = next
        } else {
            self.next = 0
        }
        
        if let previous = try container.decodeIfPresent(Int.self, forKey: .next) {
            self.previous = previous
        } else {
            self.previous = 0
        }
    }
}

struct Film: Codable {
    let title: String
    let episodeID: Int
    let openingCrawl, director, producer, releaseDate: String
    let characters, planets, starships, vehicles: [String]
    let species: [String]
    let created, edited: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case episodeID = "episode_id"
        case openingCrawl = "opening_crawl"
        case director, producer
        case releaseDate = "release_date"
        case characters, planets, starships, vehicles, species, created, edited, url
    }
}
