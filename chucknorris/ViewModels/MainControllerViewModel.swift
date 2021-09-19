//
//  MainControllerViewModel.swift
//  chucknorris
//
//  Created by Daniel on 19/09/2021.
//

import Foundation

class MainControllerViewModel {
        
    let api: ServiceProtocol
    
    init(api: ServiceProtocol) {
        self.api = api
        self.fetchJokes()
    }
    
    var navigationTitle: String = "Chuck Norris 💪"
    
    var updateUI: (() -> ())?
    
    var jokes = [JokeViewModel]() {
        didSet {
            updateUI?()
        }
    }
    
    private func fetchJokes() {
        api.fetchData("/jokes/random/10") { [weak self] (response: Result<Data, Error>) in
            guard let self = self else { return }
            switch response {
            case let .success(data):
                
                let viewModels: [JokeViewModel] = data.value.map({ joke in
                    return JokeViewModel(joke: joke)
                })
                
                let badWords: [String] = ["List", "Of", "Bad", "Words"]
                let validator = JokeValidator(badWords: badWords)
                
                self.jokes = viewModels.filter({ joke in
                    guard let isValid: Bool = try? validator.isValidJoke(joke: joke) else { return false }
                    return isValid
                })
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func refreshData() {
        fetchJokes()
    }
}
