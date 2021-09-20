//
//  JokeViewModelTests.swift
//  chucknorrisTests
//
//  Created by Daniel on 20/09/2021.
//

import XCTest
@testable import chucknorris

class JokeViewModelTests: XCTestCase {
    
    var sut: JokeViewModel!

    override func setUp() {
        let joke = Joke(id: 0, joke: "First Joke.")
        sut = JokeViewModel(joke: joke)
    }

    override func tearDown() {
        sut = nil
    }
    
    func testJokeViewModelAgainstJoke() {
        
        let expectedId: Int = 0
        let expectedText: String = "First Joke."
        
        XCTAssertEqual(sut.id, expectedId)
        XCTAssertEqual(sut.text, expectedText)
    }
    
    func testJokeViewModelCellHeight() {
        XCTAssertGreaterThan(sut.cellHeight, 0)
    }
}
