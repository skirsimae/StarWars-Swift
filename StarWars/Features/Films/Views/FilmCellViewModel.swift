//
//  FilmCellViewModel.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import Foundation

protocol FilmCellViewModelType {
    var title: String { get }
}

struct FilmCellViewModel: FilmCellViewModelType {
    private var film: Film
    
    init(film: Film) {
        self.film = film
    }
    
    var title: String {
        return film.title
    }
}

