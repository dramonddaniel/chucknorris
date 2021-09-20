//
//  JokeValidatorTests.swift
//  chucknorrisTests
//
//  Created by Daniel on 20/09/2021.
//

import XCTest
@testable import chucknorris

class JokeValidatorTests: XCTestCase {
    
    var sut: JokeValidator!
    
    override func setUp() {
        let badWords: [String] = ["Bad", "Words"]
        sut = JokeValidator(badWords: badWords)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testValidatorBadJoke() throws {
        let expected = JokeError.badJoke
        var error: JokeError?
        let badJoke = Joke(id: 0, joke: "Joke that contains bad words.")
        let joke = JokeViewModel(joke: badJoke)
        XCTAssertThrowsError(try sut.isValidJoke(joke: joke), "Joke must contain a bad word.") { thrown in
            error = thrown as? JokeError
        }
        XCTAssertNotNil(error)
        XCTAssertEqual(expected, error)
    }
}
