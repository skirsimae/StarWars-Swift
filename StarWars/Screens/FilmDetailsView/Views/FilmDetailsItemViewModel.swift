//
//  FilmDetailsItemViewModel.swift
//  StarWars
//
//  Created by Silva Kirsimae on 24/02/2023.
//

class FilmDetailsItemViewModel: ViewModelType {
    let type: FilmDetailsCellType
    
    init(type: FilmDetailsCellType) {
        self.type = type
    }
}
