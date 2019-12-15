//
//  SearchViewController.swift
//  MovieShelf
//
//  Created by Levy Cristian on 15/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - ViewModel
    var viewModel: MoviesViewModel = MoviesViewModel()
       
    // MARK: - UI Variable
    lazy var searchView: SearchView = {
        let view = SearchView()
        view.searchController.searchResultsUpdater = self
        view.searchController.delegate = self
        view.searchController.searchBar.delegate = self
        view.searchController.searchBar.sizeToFit()
        definesPresentationContext = true
        view.searchController.loadViewIfNeeded()
        view.searchController.obscuresBackgroundDuringPresentation = false
        view.moviesView.collectionView.delegate = self
        view.moviesView.collectionView.dataSource = self
        return view
    }()
    
    // MARK: - LifeCycle & Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = searchView
        setUPnavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.errorLoadingDataClosure = { (error) in
            print(error.localizedDescription)
        }
        viewModel.reloadCollectionClosure = { [weak self] in
            DispatchQueue.main.async {
            self?.searchView.moviesView.collectionView.reloadData()
            }
        }
    }
    
    func setUPnavigationBar() {
        let scb = searchView.searchController.searchBar
        navigationItem.title = "Search"
        if let textfield = scb.value(forKey: "searchField") as? UITextField {
            for subView in scb.subviews {
                for backgroundview in subView.subviews {
                    if backgroundview.isKind(of: UITextField.self) {
                        
                        let textFieldInsideUISearchBarLabel = textfield.value(forKey: "placeholderLabel") as? UILabel
                        textFieldInsideUISearchBarLabel?.text = "Search Words"
                    }
                }
            }
        }
        definesPresentationContext = true
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    func filterContentForSearchText(_ searchText: String) {
        viewModel.searchMovies(by: searchText, page: nil, erase: true)
    }
    
    @objc func output() {
        if let querry = searchView.timer.userInfo as? String {
            filterContentForSearchText(querry)
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBarIsEmpty() {
            self.searchView.moviesView.collectionView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchView.timer.invalidate()
        self.searchView.timer = Timer.scheduledTimer(timeInterval: 0.35,
                                                     target: self,
                                                     selector: #selector(output), userInfo: searchBar.text, repeats: false)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
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
             return CGSize(width: (collectionView.frame.width/2) - 8, height: (collectionView.frame.height/2.2) - 16)
         }
         
         func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             minimumLineSpacingForSectionAt section: Int) -> CGFloat {
             return 8
         }
      
      func scrollViewDidScroll(_ scrollView: UIScrollView) {
          if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
              if viewModel.currentPage < viewModel.totalOfPages {
                    viewModel.currentPage+=1
                if let querry = searchView.searchController.searchBar.text {
                    viewModel.searchMovies(by: querry, page: nil, erase: false)
                }
              }
          }
      }
      
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.cellWasTapped(atPosition: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView: SearchBarCollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SearchBarCollectionReusableView.reuseIdentifier, for: indexPath) as? SearchBarCollectionReusableView else { return UICollectionReusableView() }
            headerView.addSubview(searchView.searchController.searchBar)

            return headerView
        }
        return UICollectionReusableView()
    }
}
