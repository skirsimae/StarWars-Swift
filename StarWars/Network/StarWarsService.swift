//
//  StarWarsService.swift
//  StarWars
//
//  Created by Silva Kirsimae on 09/02/2023.
//

import RxSwift
import RxCocoa

class StarWarsService: Networking {
    static let shared = StarWarsService()
    private init () {}
    
    private let baseURL = "https://swapi.dev/api/"
    
    func fetchFilms(from endpoint: Endpoint, params: [String : String]?, successHandler: @escaping (FilmsResponse) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let urlComponents = URLComponents(string: "\(baseURL)\(endpoint.rawValue)") else {
            errorHandler(MovieError.invalidEndpoint)
            return
        }
        
        guard let url = urlComponents.url else {
            errorHandler(MovieError.invalidEndpoint)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.handleError(errorHandler: errorHandler, error: MovieError.apiError)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.handleError(errorHandler: errorHandler, error: MovieError.invalidResponse)
                return
            }
            
            guard let data = data else {
                self.handleError(errorHandler: errorHandler, error: MovieError.noData)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(FilmsResponse.self, from: data)
                DispatchQueue.main.async {
                    successHandler(response)
                }
            } catch {
                self.handleError(errorHandler: errorHandler, error: MovieError.serializationError)
            }
        }.resume()
    }
    
    private func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
        DispatchQueue.main.async {
            errorHandler(error)
        }
    }
}
