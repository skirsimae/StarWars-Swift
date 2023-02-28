//
//  FilmsListViewModel.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import RxSwift
import RxCocoa

class FilmsListViewModel {
    
    private let service: Networking
    private let disposeBag = DisposeBag()
    
    init(endpoint: Driver<Endpoint>, service: Networking) {
        self.service = service
        
        endpoint
            .drive(onNext: { [weak self] endpoint in
                self?.fetchFilms(endpoint: endpoint)
            }).disposed(by: disposeBag)
    }
    
    let _films = BehaviorRelay<[Film]>(value: [])
    let _error = BehaviorRelay<String?>(value: nil)
    
    var films: Driver<[Film]> {
        return _films.asDriver()
    }
    
    var numberOfFilms: Int {
        return _films.value.count
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    func viewModelForFilm(at index: Int) -> FilmTableViewCellViewModel? {
        guard index < _films.value.count else {
            return nil
        }
        return FilmTableViewCellViewModel(film: _films.value[index])
    }
    
    private func fetchFilms(endpoint: Endpoint) {
        self._films.accept([])
        self._error.accept(nil)
        
        service.fetchData(from: endpoint, from: nil) { (result : Result<FilmsResponse,Error>) in
            switch result {
            case .success(let films):
                self._films.accept(films.results)
            case .failure(let error):
                self._error.accept(error.localizedDescription)
            }
        }
    }
}
