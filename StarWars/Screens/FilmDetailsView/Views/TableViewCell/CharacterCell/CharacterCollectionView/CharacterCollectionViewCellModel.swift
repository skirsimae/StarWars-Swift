//
//  CharacterCollectionViewCellModel.swift
//  StarWars
//
//  Created by Silva Kirsimae on 27/02/2023.
//

import Foundation

class CharacterCollectionViewCellModel: FilmDetailsItemViewModel {
    var characterName: String
    
    init(characterName: String, type: FilmDetailsCellType) {
        self.characterName = characterName
        super.init(type: type)
    }
}
