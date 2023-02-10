//
//  FilmsViewModel.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import RxSwift
import RxCocoa

class FilmsViewModel {
    
    private let service: Networking
    private let disposeBag = DisposeBag()
    
    init(endpoint: Driver<Endpoint>, service: Networking) {
        self.service = service
        
        endpoint
            .drive(onNext: { [weak self] endpoint in
                self?.fetchFilms(endpoint: endpoint)
            }).disposed(by: disposeBag)
    }
    
    private let _films = BehaviorRelay<[Film]>(value: [])
    
    var films: Driver<[Film]> {
        return _films.asDriver()
    }
    
    var numberOfFilms: Int {
        return _films.value.count
    }
    
    func viewModelForFilm(at index: Int) -> FilmCellViewModel? {
        guard index < _films.value.count else {
            return nil
        }
        return FilmCellViewModel(film: _films.value[index])
    }
    
    private func fetchFilms(endpoint: Endpoint) {
        self._films.accept([])
        self._isFetching.accept(true)
        self._error.accept(nil)
        
        service.fetchFilms(from: endpoint, params: nil, successHandler: {[weak self] (response) in
            self?._isFetching.accept(false)
            self?._films.accept(response.results)
            
        }) { [weak self] (error) in
            self?._isFetching.accept(false)
            self?._error.accept(error.localizedDescription)
        }
    }
}
