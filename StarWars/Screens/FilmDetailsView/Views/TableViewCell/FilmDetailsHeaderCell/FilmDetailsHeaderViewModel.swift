//
//  FilmDetailsHeaderViewModel.swift
//  StarWars
//
//  Created by Silva Kirsimae on 24/02/2023.
//

class FilmDetailsHeaderViewModel: FilmDetailsItemViewModel {
    let film: Film
    
    init(film: Film, type: FilmDetailsCellType) {
        self.film = film
        super.init(type: type)
    }
    
}
