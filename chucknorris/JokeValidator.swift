//
//  JokeValidator.swift
//  chucknorris
//
//  Created by Daniel on 19/09/2021.
//

import UIKit

enum JokeError: LocalizedError {
    case badJoke
    case tooLong
    var errorDescription: String? {
        switch self {
        case .badJoke:
            return "Bad joke."
        case .tooLong:
            return "Joke is too long."
        }
    }
}

class JokeValidator {
    
    private var badWords: [String]
    private var maxCharacters: Int
    
    init(badWords: [String], maxCharacters: Int) {
        self.badWords = badWords
        self.maxCharacters = maxCharacters
    }
    
    func isValidJoke(joke: JokeViewModel) throws -> Bool {
        for word in badWords {
            guard !joke.text.lowercased().contains(word.lowercased()) else {
                throw JokeError.badJoke
            }
        }
        if joke.text.count > maxCharacters {
            throw JokeError.tooLong
        }
        return true
    }
}
