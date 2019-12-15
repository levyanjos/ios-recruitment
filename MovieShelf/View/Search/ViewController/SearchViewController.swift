//
//  SearchViewController.swift
//  MovieShelf
//
//  Created by Levy Cristian on 15/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    lazy var searchView: SearchView = {
        let view = SearchView()
        view.searchController.searchResultsUpdater = self
        view.searchController.delegate = self
        view.searchController.searchBar.delegate = self
        view.searchController.searchBar.sizeToFit()
        definesPresentationContext = true
        view.searchController.loadViewIfNeeded()
        view.searchController.obscuresBackgroundDuringPresentation = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = searchView
        setUPnavigationBar()
        
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
        
        searchView.moviesView.collectionView.addSubview(searchView.searchController.searchBar)
        definesPresentationContext = true
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    func filterContentForSearchText(_ searchText: String) {
        print(searchText)
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
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.searchView.moviesView.collectionView.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.searchView.moviesView.collectionView.endEditing(true)
        self.searchView.searchController.searchBar.endEditing(true)
    }
}
