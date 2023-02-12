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
    
    init(endpoint: Driver<Endpoint>, service: Networking) {
        self.service = service
        
        endpoint
            .drive(onNext: { [weak self] endpoint in
                self?.fetchCharacter(for: endpoint)
            }).disposed(by: disposeBag)
    }
    
    let _people = BehaviorRelay<[People]>(value: [])
    let _species = BehaviorRelay<[Species]>(value: [])
    let _error = BehaviorRelay<String?>(value: nil)
    
    var people: Driver<[People]> {
        return _people.asDriver()
    }
    
    var species: Driver<[Species]> {
        return _species.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    func viewModelForCharacters(selected control: Int, at index: Int) -> CharactersTableViewCellViewModel? {
        
        if control == 0 {
            guard index < _people.value.count else {
                return nil
            }
            return CharactersTableViewCellViewModel(character: .people(_people.value[index]))
        } else {
            guard index < _species.value.count else {
                return nil
            }
            return CharactersTableViewCellViewModel(character: .species(_species.value[index]))
        }
    }
    
    private func fetchCharacter(for endpoint: Endpoint) {
        switch endpoint {
        case .people:
            self._people.accept([])
            service.fetchData(from: endpoint) { (result : (Result<PeopleResponse, Error>)) in
                switch result {
                case .success(let people):
                    self._people.accept(people.results)

                case .failure(let error):
                    self._error.accept(error.localizedDescription)
                }
            }
            
        case .species:
            self._species.accept([])
            service.fetchData(from: endpoint) { (result : (Result<SpeciesResponse, Error>)) in
                switch result {
                case .success(let species):
                    self._species.accept(species.results)
                case .failure(let error):
                    self._error.accept(error.localizedDescription)
                }
            }
        case .films:
            return
        }
        self._error.accept(nil)
    }
}
