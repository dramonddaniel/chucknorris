//
//  Models.swift
//  chucknorris
//
//  Created by Daniel on 19/09/2021.
//

import Foundation

struct Joke: Codable {
    let id: Int
    let joke: String
}

struct Data: Codable {
    let value: [Joke]
}
