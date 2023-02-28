//
//  CharactersViewModel.swift
//  StarWars
//
//  Created by Silva Kirsimae on 10/02/2023.
//

import RxSwift
import RxCocoa
import RxDataSources

struct CharactersViewModel {
    
    private let service: Networking
    private let disposeBag = DisposeBag()
    
    init(service: Networking) {
        self.service = service
    }
    
    let _characters = BehaviorRelay<[CharacterModel]>(value: [])
    let _selectedCharacterType = BehaviorRelay<CharacterType>(value: .people)
    let _error = BehaviorRelay<String?>(value: nil)
    
    var characters: Driver<[CharacterModel]> {
        return _characters.asDriver()
    }
    
    var selectedCharacterType: Driver<CharacterType> {
        return _selectedCharacterType.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    func fetchCharacters() {
        switch _selectedCharacterType.value {
        case .people:
            service.fetchData(from: .people, from: nil) { (result : (Result<PeopleResponse, Error>)) in
                switch result {
                case .success(let people):
                    self._characters.accept([CharacterModel(model: "", items: people.results.map({ person in
                        return Character.person(person)
                    }))])
                    
                case .failure(let error):
                    self._error.accept(error.localizedDescription)
                }
            }
        case .species:
            service.fetchData(from: .species, from: nil) { (result : (Result<SpeciesResponse, Error>)) in
                switch result {
                case .success(let species):
                    self._characters.accept([CharacterModel(model: "", items: species.results.map({ species in
                        return Character.species(species)
                    }))])
                case .failure(let error):
                    self._error.accept(error.localizedDescription)
                }
            }
        }
    }
}
