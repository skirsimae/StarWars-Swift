//
//  FilmViewModel.swift
//  StarWars
//
//  Created by Silva Kirsimae on 11/02/2023.
//

import RxSwift
import RxCocoa

class FilmViewModel {
    
    private var film: Film
    private let service: Networking
    private let disposeBag = DisposeBag()
    
    init(film: Film, endpoint: Driver<Endpoint>, service: Networking) {
        self.film = film
        self.service = service
        
        endpoint
            .drive(onNext: { [weak self] endpoint in
                self?.fetchCharacters(endpoint: endpoint, param: film.characters.endIndex)
            }).disposed(by: disposeBag)
    }
    
    var title: String {
        return film.title
    }
    var episode: String {
        return String(describing: film.episodeID)
    }

    var openingCrawl: String {
        return film.openingCrawl
    }

    var characters: [String] {
        return film.characters
    }

    
    private func fetchCharacters(endpoint: Endpoint, param: Int) {
        //TODO: Fetch people and species
    }
}

