//
//  ViewCode.swift
//  MovieShelf
//
//  Created by Levy Cristian on 12/12/19.
//  Copyright © 2019 Levy Cristian. All rights reserved.
//

import Foundation

/**
 Protocol enable to make standardized application View code
 
 You must to call `setupView()` in each view initialization
 */
protocol ViewCode {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfigurantion()
    func setupView()
}

extension ViewCode {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfigurantion()
    }
}
