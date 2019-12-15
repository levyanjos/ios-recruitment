//
//  MovieDetailsViewController.swift
//  MovieShelf
//
//  Created by Levy Cristian on 13/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    // MARK: - ViewModel
    var viewModel: MovieDetailsViewModel
    
    // MARK: - UI Variable
    
    private lazy var movieDetailsView: MovieDetailsView = {
        let view = MovieDetailsView()
        view.tableView.delegate = self
        view.tableView.dataSource = self
        return view
    }()
    
    // MARK: - LifeCycle
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = movieDetailsView
        movieDetailsView.headerView.imageView.image = viewModel.image
        viewModel.loadMovies(page: nil)
        viewModel.reloadCollectionClosure = {
            self.movieDetailsView.tableView.reloadData()
        }
        viewModel.errorLoadingDataClosure = { error in
            print(error.localizedDescription)
        }
    }

}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.section == 0 {
             guard let descriptionCell = tableView.dequeueReusableCell(withIdentifier: DescripitonTableViewCell.reuseIdentifier, for: indexPath) as? DescripitonTableViewCell
            else { return UITableViewCell() }
            descriptionCell.descriptionLabel.text = viewModel.overview
            cell = descriptionCell
        } else {
            guard let recommendationCell = tableView.dequeueReusableCell(withIdentifier: RecommendationTableViewCell.reuseIdentifier, for: indexPath) as? RecommendationTableViewCell
                else { return UITableViewCell() }
            recommendationCell.collectionView.delegate = self
            recommendationCell.collectionView.dataSource = self
            cell = recommendationCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Descrição"
            
        } else {
            return "Recomendações"
        }
    }
}

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.moviesCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = viewModel.moviesCellViewModels[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? RecommendationCollectionViewCell
            else { return UICollectionViewCell()}
        
        cellViewModel.downloadImage { (image) in
            cell.postImage = image
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/3) - 16, height: collectionView.frame.height)
    }
       
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
       
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
       if (scrollView.contentOffset.x >= (scrollView.contentSize.width - scrollView.frame.size.width)) {
           if viewModel.currentPage < viewModel.totalOfPages {
               viewModel.currentPage+=1
               viewModel.loadMovies(page: nil)
           }
       }
   }
}
