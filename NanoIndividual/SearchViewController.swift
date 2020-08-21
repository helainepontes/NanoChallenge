//
//  SearchViewController.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 18/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    
    func configureVC() {
        view.backgroundColor = .backgroundGray
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
    }
}
