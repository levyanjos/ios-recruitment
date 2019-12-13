//
//  MoviesViewController.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    // MARK: - ViewModel
    var viewModel: MoviesViewModel = MoviesViewModel()
    
    // MARK: - UI Variable
    
    private lazy var moviesView: MoviesView = {
        let view = MoviesView()
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        return view
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = moviesView
        
    }
    
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = viewModel.moviesCellViewModels[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? MovieCollectionViewCell else {
                   return UICollectionViewCell()
               }
        cell.labelName.text = cellViewModel.name
        
        return
        
    }
    
    
}
