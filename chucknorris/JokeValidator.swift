//
//  JokeValidator.swift
//  chucknorris
//
//  Created by Daniel on 19/09/2021.
//

import UIKit

enum JokeError: LocalizedError {
    case badJoke
    var errorDescription: String? {
        switch self {
        case .badJoke:
            return "Bad joke."
        }
    }
}

struct JokeValidator {
    
    private let badWords: [String]
    
    init(badWords: [String]) {
        self.badWords = badWords
    }
    
    func isValidJoke(joke: JokeViewModel) throws -> Bool {
        for word in badWords {
            guard !joke.text.contains(word) else {
                throw JokeError.badJoke
            }
        }
        return true
    }
}
