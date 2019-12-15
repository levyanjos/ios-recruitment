//
//  SearchView.swift
//  MovieShelf
//
//  Created by Levy Cristian on 15/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class SearchView: UIView {

    lazy var searchController: UISearchController = {
        let searchControl = UISearchController(searchResultsController: nil)
        return searchControl
    }()
    
    lazy var moviesView: MoviesView = {
        let view = MoviesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.collectionView.register(SearchBarCollectionReusableView.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: SearchBarCollectionReusableView.reuseIdentifier)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        view.collectionView.setCollectionViewLayout(flowLayout, animated: true)
        
        return view
    }()
    
    public lazy var timer: Timer = {
        let time = Timer()
        return time
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()

    }
}

extension SearchView: ViewCode {
    func buildViewHierarchy() {
        addSubview(moviesView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            moviesView.topAnchor.constraint(equalTo: topAnchor),
            moviesView.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesView.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviesView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = .white
    }
}
