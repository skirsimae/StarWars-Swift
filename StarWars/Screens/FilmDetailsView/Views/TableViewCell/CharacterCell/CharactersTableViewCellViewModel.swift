//
//  CharactersCellViewModel.swift
//  StarWars
//
//  Created by Silva Kirsimae on 27/02/2023.
//

import Foundation

class CharactersTableViewCellViewModel: FilmDetailsItemViewModel {
    let people: [Person]
    
    init(people: [Person], type: FilmDetailsCellType) {
        self.people = people
        super.init(type: type)
    }
}

//extension CharactersTableViewCellViewModel {
//    func displayableItem(at indexPath: IndexPath) -> DisplayableCharacter? {
//        guard let person = people[indexPath.row] else { return nil }
//
//        return DisplayableCharacter(character: person)
//    }
//}
