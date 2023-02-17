//
//  CharactersCellViewModel.swift
//  StarWars
//
//  Created by Silva Kirsimae on 12/02/2023.
//

import RxCocoa
import RxDataSources

typealias CharacterModel = AnimatableSectionModel<String, Character>

enum Character: IdentifiableType, Equatable {
    case person(Person)
    case species(Species)
    
    var identity: String {
        switch self {
        case let .person(value):
            return value.identity
        case let .species(value):
            return value.identity
        }
    }
    
    var cellIdentifier: String {
        switch self {
        case .person:
            return "person"
        case .species:
            return "species"
        }
    }
}


enum CharacterType: String {
    case people = "people"
    case species = "species"
}
