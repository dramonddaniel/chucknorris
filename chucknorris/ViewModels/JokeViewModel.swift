//
//  JokeViewModel.swift
//  chucknorris
//
//  Created by Daniel on 19/09/2021.
//

import UIKit

class JokeViewModel {
    
    let id: Int
    let text: String
    var cellHeight: CGFloat = 0
    
    init(joke: Joke) {
        self.id = joke.id
        self.text = joke.joke
        self.cellHeight = getCellHeight()
    }
    
    private func getCellHeight() -> CGFloat {
        var size: CGFloat = 0
        let horizontalMargin: CGFloat = 12 + 12
        let verticalMargin: CGFloat = 12 + 12
        let extra: CGFloat = 1
        size = text.sizeFromText(width: UIScreen.main.bounds.width, horizontalMargin: horizontalMargin, font: .systemFont(ofSize: 14)).height + verticalMargin
        return size + extra
    }
}
