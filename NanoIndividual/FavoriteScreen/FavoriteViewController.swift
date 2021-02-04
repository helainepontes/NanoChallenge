//
//  FavoriteViewController.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 18/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    let tableView: UITableView = UITableView()
    var listOfFavorites = [MealPersistence]()
    let coreDataManager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //listOfFavorites = getFavorite.persistedObjects()
        listOfFavorites = coreDataManager.fetchFavoriteMeal()!//NÃO MATAR ESSE GATINHO
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func configureVC() {
       view.addSubview(tableView)
       self.view.insertSubview(UIView(frame: .zero), at: 0)
       view.backgroundColor = .backgroundYellow
       navigationController?.navigationBar.prefersLargeTitles = true
       navigationItem.title = "Favorites"
       navigationController?.navigationBar.tintColor = .coralOrange
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .backgroundYellow
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = true
        let cellNib = UINib(nibName: AllMealsOfCategoryTableViewCell.xibName, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: AllMealsOfCategoryTableViewCell.identifier)
        
        //Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 132).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfFavorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllMealsOfCategoryTableViewCell.identifier, for: indexPath) as? AllMealsOfCategoryTableViewCell else {
            fatalError()
        }
        cell.mealImageView.image = UIImage(named: "frango")
        cell.mealTitle.text = listOfFavorites[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            let mealToRemove = self.listOfFavorites[indexPath.row]
            self.coreDataManager.removeFavoriteMeal(meal: mealToRemove)
            self.listOfFavorites.remove(at: indexPath.row)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            tableView.beginUpdates()
//            let mealToRemove = listOfFavorites[indexPath.row]
//            coreDataManager.removeFavoriteMeal(meal: mealToRemove)
//            //tableView.deleteRows(at: [indexPath], with: .automatic)
//            tableView.endUpdates()
//        }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let meal = listOfFavorites[indexPath.row]
//        navigationController?.pushViewController(MealDetailViewController(meal: meal, image: ), animated: true)
//    }

}
