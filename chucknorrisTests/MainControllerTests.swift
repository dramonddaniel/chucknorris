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
        sut.view.setNeedsLayout()
        sut.view.layoutIfNeeded()
    }

    override func tearDown() {
        sut = nil
    }
    
    func testMainControllerNavigationTitle() {
        let expected: String = "iOS Task"
        let result: String = sut.viewModel.navigationTitle
        XCTAssertEqual(expected, result)
    }

    func testCollectionViewNotNilAfterViewDidLoad() {
        XCTAssertNotNil(sut.collectionView)
    }

    func testItemsForCollectionView() {
        XCTAssertGreaterThan(sut.viewModel.jokes.count, 0)
    }
    
    func testCollectionViewCellText() {
        let expected: [String] = ["First Joke.", "Second Joke."]
        for (item, text) in expected.enumerated() {
            let indexPath = IndexPath(item: item, section: 0)
            let cell = sut.collectionView.cellForItem(at: indexPath) as? JokeCell
            XCTAssertEqual(cell?.textLabel.text, text)
        }
    }
    
    func testCollectionViewCellHeight() {
        let index: Int = 0
        let indexPath = IndexPath(item: index, section: 0)
        let cell = sut.collectionView.cellForItem(at: indexPath) as? JokeCell
        let cellHeight: CGFloat = cell?.bounds.height ?? 0
        XCTAssertGreaterThan(cellHeight, 0)
        XCTAssertEqual(sut.viewModel.jokes[index].cellHeight, cellHeight)
    }
}
