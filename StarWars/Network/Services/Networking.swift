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


public enum Endpoint: String, CustomStringConvertible, CaseIterable {
    case films
    case people
    case species
    
    public var description: String {
        switch self {
        case .films: return "Films"
        case .people: return "People"
        case .species: return "Species"
        }
    }
    
    public init?(index: Int) {
        switch index {
        case 0: self = .films
        case 1: self = .people
        case 2: self = .species
        default: return nil
        }
    }
    
    public init?(description: String) {
        guard let first = Endpoint.allCases.first(where: { $0.description == description }) else {
            return nil
        }
        self = first
    }
    
}

public enum MovieError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}

