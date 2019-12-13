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
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadMovies(page: nil)
        viewModel.errorLoadingDataClosure = { (error) in
            print(error.localizedDescription)
        }
        viewModel.reloadCollectionClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.moviesView.collectionView.reloadData()
            }
        }
    }
    
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        
        cellViewModel.downloadImage { (image) in
            cell.imageView.image = image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/2) - 16, height: (collectionView.frame.height/2.5) - 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            viewModel.currentPage+=1
            viewModel.loadMovies(page: nil)
        }
    }
}
