//
//  MainControllerTests.swift
//  MainControllerTests
//
//  Created by Daniel on 19/09/2021.
//

import XCTest
@testable import chucknorris

class MainControllerTests: XCTestCase {

    var sut: MainController!

    override func setUp() {

        let api = MockService(jokes: [
            Joke(id: 0, joke: "First Joke."),
            Joke(id: 0, joke: "Second Joke."),
        ])

        let viewModel = MainControllerViewModel(api: api)
        sut = MainController(viewModel: viewModel)
        _ = sut.view
    }

    override func tearDown() {
        sut = nil
    }
    
    func testMainControllerNavigationTitle() {
        let expected: String = "Chuck Norris 💪"
        let result: String = sut.viewModel.navigationTitle
        XCTAssertEqual(expected, result)
    }

    func testCollectionViewNotNilAfterViewDidLoad() {
        XCTAssertNotNil(sut.collectionView)
    }

    func testItemsForCollectionView() {
        XCTAssertGreaterThan(sut.viewModel.jokes.count, 0)
    }
}
