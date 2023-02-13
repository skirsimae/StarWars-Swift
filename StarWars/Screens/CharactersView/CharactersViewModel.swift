//
//  CharactersViewModel.swift
//  StarWars
//
//  Created by Silva Kirsimae on 10/02/2023.
//

import RxSwift
import RxCocoa

class CharactersViewModel {
    
    private let service: Networking
    private let disposeBag = DisposeBag()
    
    init(service: Networking) {
        self.service = service
    }
    
    let _people = BehaviorRelay<[Person]>(value: [])
    let _species = BehaviorRelay<[Species]>(value: [])
    let _selectedCharacterType = BehaviorRelay<CharacterType>(value: .person)
    let _error = BehaviorRelay<String?>(value: nil)
    
    var people: Driver<[Person]> {
        return _people.asDriver()
    }
    
    var species: Driver<[Species]> {
        return _species.asDriver()
    }
    
    var selectedCharacterType: Driver<CharacterType> {
        return _selectedCharacterType.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    func viewModelForCharacters(selected control: Int, at index: Int) -> CharactersTableViewCellViewModel? {
        if control == 0 {
            guard index < _people.value.count else {
                return nil
            }
            return CharactersTableViewCellViewModel(character: .person(_people.value[index]))
        } else {
            guard index < _species.value.count else {
                return nil
            }
            return CharactersTableViewCellViewModel(character: .species(_species.value[index]))
        }
    }
    
    func fetchCharacter() {
        switch _selectedCharacterType.value {
        case .person:
            self._people.accept([])
            service.fetchData(from: .people) { (result : (Result<PeopleResponse, Error>)) in
                switch result {
                case .success(let people):
                    self._people.accept(people.results)
                    
                case .failure(let error):
                    self._error.accept(error.localizedDescription)
                }
            }
            
        case .species:
            self._species.accept([])
            service.fetchData(from: .species) { (result : (Result<SpeciesResponse, Error>)) in
                switch result {
                case .success(let species):
                    self._species.accept(species.results)
                case .failure(let error):
                    self._error.accept(error.localizedDescription)
                }
            }
        }
        self._error.accept(nil)
    }
}
