//
//  StarWarsNetworkService.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import RxSwift

protocol Networking {
    
    func fetchFilms(from endpoint: Endpoint, params: [String: String]?, successHandler: @escaping (_ response: FilmsResponse) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
}


public enum Endpoint: String, CaseIterable {
    case films
    case people
}

public enum MovieError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}

