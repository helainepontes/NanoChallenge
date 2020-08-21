//
//  MainTabBarController.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 18/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTabBar()
    }
    
    func setUpTabBar(){
        let categoryController = UINavigationController(rootViewController: CategoryViewController())
        categoryController.tabBarItem.image = UIImage(systemName: "square.grid.2x2")
        categoryController.tabBarItem.title = "Category"
        
        let favoriteController = UINavigationController(rootViewController: FavoriteViewController())
        favoriteController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        favoriteController.tabBarItem.title = "Favorite"
        
        let searchController = UINavigationController(rootViewController: SearchViewController())
        searchController.tabBarItem.image = UIImage(systemName: "star")
        searchController.tabBarItem.title = "Search"
        
        viewControllers = [categoryController, favoriteController, searchController]
        
        //Cor da tab
        tabBar.barTintColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.94)
        
        //Cor do ícone selecionado
        UITabBar.appearance().tintColor = .coralOrange
    }
}
