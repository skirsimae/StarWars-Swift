//
//  CharactersCellViewModel.swift
//  StarWars
//
//  Created by Silva Kirsimae on 12/02/2023.
//

import Foundation

class CharactersTableViewCellViewModel {

    private var character: Character
    
    init(character: Character) {
        self.character = character
    }
    
}

enum Character {
    case person(Person)
    case species(Species)
}

enum CharacterType: String {
    case person = "person"
    case species = "species"
}
