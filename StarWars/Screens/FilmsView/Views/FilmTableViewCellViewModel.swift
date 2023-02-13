//
//  FilmTableViewCellViewModel.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import Foundation

class FilmTableViewCellViewModel {
    
    private var film: Film
    
    init(film: Film) {
        self.film = film
    }
    
    var title: String {
        return film.title
    }
}

