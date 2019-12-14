//
//  DescripitonTableViewCell.swift
//  MovieShelf
//
//  Created by Levy Cristian on 14/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class DescripitonTableViewCell: UITableViewCell {

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
       
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }

}

extension DescripitonTableViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        
    }
}
