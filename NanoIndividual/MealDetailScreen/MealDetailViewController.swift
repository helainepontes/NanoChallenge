//
//  MealDetailViewController.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 19/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import UIKit

class MealDetailViewController: UIViewController {

    var meal: String
    var mealImage = UIImageView()
    var tableView = UITableView()
    var detailsView = UIView()
    var gradientView = UIView()
    
    init(meal: String, image: UIImage) {
        self.meal = meal
        self.mealImage.image = image
        super.init(nibName: nil, bundle: nil)
    }
    var detailMeal = [MealDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundYellow
        
        //Chamada das funções
        mealRequest()
        configImage()
        configDetailsView()
        configGradientView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let gradient = FirstBackgroundGradient().gradientLayer
        gradientView.layer.addSublayer(gradient)
        gradient.frame = gradientView.bounds
    }
    
    func mealRequest() {
        let formattedString = meal.replacingOccurrences(of: " ", with: "%20")
        let categoryRequest = NetworkRequest(meal: formattedString)
        categoryRequest.getMealDetail { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let meal):
                self.detailMeal = meal
                createDetailNewFile(data: meal)
            }
        }
        guard let saveDetails = readDetailDataFromFile() else {
            return
        }
        //print(saveDetails)
        detailMeal = saveDetails
        //mealImage.image = try? UIImage(withContentsOfUrl: detailMeal[0].strMealThumb)
    }
    
    func configGradientView() {
        view.addSubview(gradientView)
        
        //Constraints
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        gradientView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func configImage() {
        view.addSubview(mealImage)
        
        //Constraints
        mealImage.translatesAutoresizingMaskIntoConstraints = false
        mealImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mealImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mealImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mealImage.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 304).isActive = true
    }
    
    func configDetailsView() {
        view.addSubview(detailsView)
        detailsView.backgroundColor = .red
        detailsView.layer.masksToBounds = true
        detailsView.layer.cornerRadius = 12
        configTableView()
        
        //Constraints
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        detailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 294).isActive = true
        detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        detailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func configTableView() {
        detailsView.addSubview(tableView)
        tableView.backgroundColor = .backgroundYellow
//        tableView.separatorStyle = .none
        
        //TableViewHeader
        let tableHeader = HeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 65))
        tableHeader.mealTitle.text = meal
        tableView.tableHeaderView = tableHeader
        tableView.sectionHeaderHeight = 100
        
        //Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: detailsView.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: detailsView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: detailsView.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: detailsView.bottomAnchor).isActive = true
    }

}

extension MealDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Ingredients"
        case 1:
            return "Instructions"
        default:
            return ""
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = UITableViewCell()
            cell.textLabel?.text = detailMeal[indexPath.row].strIngredient1
            return cell
        case 1:
            let cell = UITableViewCell()
            cell.textLabel?.text = detailMeal[indexPath.row].strInstructions
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
}
