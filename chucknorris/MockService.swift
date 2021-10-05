//
//  MockService.swift
//  chucknorris
//
//  Created by Daniel on 19/09/2021.
//

import Foundation

class MockService: ServiceProtocol {

    private var jokes: [Joke]

    init(jokes: [Joke]) {
        self.jokes = jokes
    }
    
    func fetchData<T>(_ endpoint: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let data = Data(value: jokes)
        guard let data = try? JSONEncoder().encode(data),
              let decoded = try? JSONDecoder().decode(T.self, from: data) else { return }
        return completion(.success(decoded))
    }
}
