//
//  MovieDetailsView.swift
//  MovieShelf
//
//  Created by Levy Cristian on 13/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {
    
    // MARK: - UI Variable
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.register(DescripitonTableViewCell.self, forCellReuseIdentifier: DescripitonTableViewCell.reuseIdentifier)
        tableView.register(RecommendationTableViewCell.self, forCellReuseIdentifier: RecommendationTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private(set) lazy var headerView: PosterView = {
        let rect = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: 0.0)
        let headerView = PosterView(frame: rect)
        headerView.imageView.contentMode = .scaleAspectFill
        headerView.imageView.clipsToBounds = true
        return headerView
    }()
   
    // MARK: - Initializators
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
        
}

extension MovieDetailsView: ViewCode {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        backgroundColor = .white
        
        tableView.tableHeaderView = headerView

        if let headerView = tableView.tableHeaderView {
            let height = UIScreen.main.bounds.height * 0.6
            
            var headerFrame = headerView.frame
            
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }

    }
}
