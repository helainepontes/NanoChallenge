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
    var listOfFavorites = [String]()
    let coreDataManager = CoreDataManager()
    var listAux = [String]()
    var detailMeal = [MealDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configTableView()
        //listOfFavorites = coreDataManager.fetchFavoriteMealNames()!
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listOfFavorites = coreDataManager.fetchFavoriteMealNames()!//NÃO MATAR ESSE GATINHO
        loadRequests()
    }

    func mealRequest(meal: String) {
        let formattedString = meal.replacingOccurrences(of: " ", with: "%20")
        //print("String: \(formattedString)")
        let categoryRequest = NetworkRequest(meal: formattedString)
        categoryRequest.getMealDetail { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let meal):
                self.detailMeal.append(meal[0])
                //createDetailNewFile(data: meal)
            }
        }
//        guard let saveDetails = readDetailDataFromFile() else {
//            return
//        }
        //detailMeal.append(contentsOf: saveDetails)
    }
    
    func loadRequests() {
        detailMeal = []
        if listOfFavorites.count != 0 {
            for index in 0...listOfFavorites.count - 1 {
                mealRequest(meal: listOfFavorites[index])
            }
        }
//        tableView.reloadData()
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
        print("DETAILS MEALS == \(detailMeal)")
        if detailMeal.count == 0 {
            tableView.emptyState(textTitle: "You don't have any favorites", textDescription: "", image: "")
        } else {
            tableView.restore()
        }
        return detailMeal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllMealsOfCategoryTableViewCell.identifier, for: indexPath) as? AllMealsOfCategoryTableViewCell else {
            fatalError()
        }
        cell.mealTitle.text = detailMeal[indexPath.row].strMeal
        cell.mealImageView.image = try? UIImage(withContentsOfUrl: detailMeal[indexPath.row].strMealThumb)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            let meal = self.coreDataManager.fetchFavoriteMeal()
            let mealToRemove = meal![indexPath.row].name
            self.coreDataManager.removeFavoriteMeal(name: mealToRemove!)
            self.listOfFavorites.remove(at: indexPath.row)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = listOfFavorites[indexPath.row]
        let image = try? UIImage(withContentsOfUrl: detailMeal[indexPath.row].strMealThumb)
        navigationController?.pushViewController(MealDetailViewController(meal: meal, image: image!), animated: true)
    }

}
