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
        let maxCharacters: Int = 40
        
        sut = JokeValidator(badWords: badWords,
                            maxCharacters: maxCharacters)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testValidatorBadJoke() throws {
        let expected = JokeError.badJoke
        var error: JokeError?
        let invalidJoke = Joke(id: 0, joke: "Joke that contains bad words.")
        let joke = JokeViewModel(joke: invalidJoke)
        XCTAssertThrowsError(try sut.isValidJoke(joke: joke), "Joke must contain a bad word.") { thrown in
            error = thrown as? JokeError
        }
        XCTAssertNotNil(error)
        XCTAssertEqual(expected, error)
    }
    
    func testValidatorTooLong() throws {
        let expected = JokeError.tooLong
        var error: JokeError?
        let invalidJoke = Joke(id: 0, joke: "Joke that has more than the maximum characters.")
        let joke = JokeViewModel(joke: invalidJoke)
        XCTAssertThrowsError(try sut.isValidJoke(joke: joke), "Joke must be less than validator maximum characters.") { thrown in
            error = thrown as? JokeError
        }
        XCTAssertNotNil(error)
        XCTAssertEqual(expected, error)
    }
}
