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
    
    init(endpoint: Driver<Endpoint>, service: Networking) {
        self.service = service
    }
}
