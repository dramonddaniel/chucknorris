//
//  JokeCell.swift
//  chucknorris
//
//  Created by Daniel on 19/09/2021.
//

import UIKit

class JokeCell: UICollectionViewCell {
    
    var viewModel: JokeViewModel! {
        didSet {
            textLabel.text = viewModel.text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 14)
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    private func setupViews() {
        
        backgroundColor = .white
        
        addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -12),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12)
        ])
    }
}
