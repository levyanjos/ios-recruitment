//
//  RecommendationCollectionViewCell.swift
//  MovieShelf
//
//  Created by Levy Cristian on 14/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import UIKit

class RecommendationCollectionViewCell: UICollectionViewCell {
    
    private lazy var postView: PosterView = {
        let poster = PosterView()
        return poster
    }()
    
    var postImage: UIImage? {
        get {
            return postView.imageView.image
        }
        set(newValue) {
            self.postView.imageView.image = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
        
    }
}

extension RecommendationCollectionViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(postView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            postView.topAnchor.constraint(equalTo: topAnchor),
            postView.leadingAnchor.constraint(equalTo: leadingAnchor),
            postView.trailingAnchor.constraint(equalTo: trailingAnchor),
            postView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfigurantion() {
        
    }
}
