//
//  Service.swift
//  chucknorris
//
//  Created by Daniel on 19/09/2021.
//

import Foundation

// http://api.icndb.com/jokes/random/10

protocol ServiceProtocol {
    func fetchData<T: Decodable>(_ endpoint: String, completion: @escaping (Result<T, Error>) -> Void)
}

class Service: ServiceProtocol {
    
    private let baseURL: String = "http://api.icndb.com"
    
    func fetchData<T: Decodable>(_ endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else { return }
        let _ = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                return completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    return completion(.success(decoded))
                }
            } catch let err {
                return completion(.failure(err))
            }
        }.resume()
    }
}
