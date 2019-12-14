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
    }

}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DescripitonTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? DescripitonTableViewCell
            else { return UITableViewCell() }
        cell.descriptionLabel.text = viewModel.overview
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Description"
    }
}
