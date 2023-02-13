//
//  StarWarsService.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import RxSwift

class StarWarsService: Networking {
    static let shared = StarWarsService()
    private init () {}
    
    private let baseURL = "https://swapi.dev/api/"
    
    func fetchData<T: Decodable>(from endpoint: Endpoint, resultHandler: @escaping (Result<T, Error>) -> Void) {
        guard let urlComponents = URLComponents(string: "\(baseURL)\(endpoint.rawValue)") else {
            resultHandler(.failure(MovieError.invalidEndpoint))
            return
        }
        
        guard let url = urlComponents.url else {
            resultHandler(.failure(MovieError.invalidEndpoint))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                resultHandler(.failure(MovieError.apiError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                resultHandler(.failure(MovieError.invalidResponse))
                return
            }
            
            guard let data = data else {
                resultHandler(.failure(MovieError.noData))
                return
            }
            
            do {
                guard let response = try? JSONDecoder().decode(T.self, from: data) else {
                    resultHandler(.failure(MovieError.serializationError))
                    return
                }
                DispatchQueue.main.async {
                    resultHandler(.success(response))
                }
            }
        }
        .resume()
    }
}


