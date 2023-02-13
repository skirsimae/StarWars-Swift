//
//  StarWarsNetworkService.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import RxSwift

protocol Networking {
    func fetchData<T: Decodable>(from endpoint: Endpoint, resultHandler: @escaping (Result<T, Error>) -> Void)
}


public enum Endpoint: String, CaseIterable {
    case films
    case people
    case species
}

public enum MovieError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}
