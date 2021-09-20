//
//  MainController.swift
//  chucknorris
//
//  Created by Daniel on 19/09/2021.
//

import UIKit

private let cellId = "cellId"

class MainController: UIViewController {
    
    var viewModel: MainControllerViewModel
    
    convenience init() {
        fatalError("init() has not been implemented")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(viewModel: MainControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.updateUI = { [unowned self] in
            /**
             I'm using **unowned** over **weak** here
             as we know that self won't ever be nil.
             */
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
        }
        
        setupViews()
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    @objc func refresh(_ sender: UIRefreshControl) {
        viewModel.refreshData()
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.alwaysBounceHorizontal = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(JokeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.refreshControl = refreshControl
        return collectionView
    }()
    
    private func collectionViewConstraints() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
    }
    
    private func setupViews() {
        
        navigationItem.title = viewModel.navigationTitle
        
        view.backgroundColor = UIColor(white: 1.0, alpha: 0.92)
        
        collectionViewConstraints()
    }
}

extension MainController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.jokes.count
    }
}

extension MainController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let joke: JokeViewModel = viewModel.jokes[indexPath.item]
        return CGSize(width: collectionView.frame.width, height: joke.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! JokeCell
        cell.viewModel = viewModel.jokes[indexPath.item]
        return cell
    }
}
