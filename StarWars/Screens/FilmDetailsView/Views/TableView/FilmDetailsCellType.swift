//
//  FilmDetailsCellType.swift
//  StarWars
//
//  Created by Silva Kirsimae on 24/02/2023.
//

enum FilmDetailsCellType: Equatable {
    case descriptionHeader
    case characters
}

extension FilmDetailsCellType {
    var cellType: String {
        switch self {
        case .descriptionHeader:
            return FilmDetailsHeaderTableViewCell.identifier
        case .characters:
            return CharactersTableViewCell.identifier
        }
    }
}
