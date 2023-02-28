//
//  FilmDetailsViewModel.swift
//  StarWars
//
//  Created by Silva Kirsimae on 11/02/2023.
//

import RxSwift
import RxCocoa

class FilmDetailsViewModel: ViewModelType {
    
    private var film: Film
    private let service: Networking
    private let disposeBag = DisposeBag()
    
    let filmDetailsCellType: [FilmDetailsCellType] = [.descriptionHeader, .characters]
    
    var input = Input()
    lazy var output: Output = transform(input: input)
    
    init(film: Film, service: Networking) {
        self.film = film
        self.service = service
        
        for person in self.film.characters {
            self.fetchCharacters(customEndpoint: person)
        }
    }
    
    let _people = BehaviorRelay<[Person]>(value: [])
    let _error = BehaviorRelay<String?>(value: nil)
    
    var title: String {
        return film.title
    }
    
    var characters: Driver<[Person]> {
        return _people.asDriver()
    }
    
    var numberOfCharacters: Int {
        return _people.value.count
    }

    private func fetchCharacters(customEndpoint: String) {
        self.service.fetchData(from: nil, from: customEndpoint) { (result: Result<Person, Error>) in
            switch result {
            case .success(let person):
                self._people.accept(self._people.value + [person])
            case .failure(let error):
                self._error.accept(error.localizedDescription)
            }
        }
    }
    
    private func refine(characters: [Person]) -> [FilmDetailsItemViewModel] {
        return filmDetailsCellType.map { cellType -> FilmDetailsItemViewModel in
            switch cellType {
            case .descriptionHeader:
                return FilmDetailsHeaderViewModel(film: film, type: cellType)
            case .characters:
                return CharactersTableViewCellViewModel(people: characters, type: cellType)
            }
        }
    }
}

extension FilmDetailsViewModel: ReactiveConnectable {
    struct Input {
        let onViewDidLoad = PublishSubject<Void>()
    }
    
    struct Output {
        let filmDetailsItemViewModels: Observable<[FilmDetailsItemViewModel]>
    }
    
    func transform(input: Input) -> Output {
                
        let filmDetailsItemViewModels = self.characters.asObservable().map { people in
            self.refine(characters: people)
        }
        
        return Output(filmDetailsItemViewModels: filmDetailsItemViewModels)
    }
}
