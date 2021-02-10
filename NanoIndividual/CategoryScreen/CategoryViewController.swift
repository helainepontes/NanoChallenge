//
//  CategoryViewController.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 18/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var waitView: WaitViewController?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        return collection
    }()
    
    var listOfCategory = [Category]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var categoryImage = [Data]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        categoryRequest()
    }
    
    func categoryRequest() {
        let categoryRequest = NetworkRequest()
        categoryRequest.getCategories { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let categories):
                self.listOfCategory = categories
                if self.requestLoad() {
                    self.waitView?.presentCategoryScreen()
                }
                createCategoryNewFile(data: categories)
            }
        }
        guard let saveCategories = readCategoryDataFromFile() else {
            return
        }
        listOfCategory = saveCategories
        
//        for index in 0..<saveCategories.count {
//            let imageRequest = NetworkRequest(image: saveCategories[index].strCategoryThumb)
//            imageRequest.getImage { result in
//                switch result {
//                case .failure(let error):
//                    print(error)
//                case .success(let image):
//                    self.categoryImage.append(image)
//                }
//            }
//        }
    }
    
    func configureVC() {
        self.view.insertSubview(UIView(frame: .zero), at: 0)
        view.addSubview(collectionView)
        view.backgroundColor = .backgroundYellow
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Category"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        //Metódo de configuração da CollectionView
        configureCollectionView()
        collectionViewConstraits()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self 
        collectionView.dataSource = self
        collectionView.backgroundColor = .backgroundYellow
        collectionView.isUserInteractionEnabled = true
        let cellNib = UINib(nibName: CategoryCollectionViewCell.xibName, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    func collectionViewConstraits() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 132).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func requestLoad() -> Bool {
        if listOfCategory.count == 14 {
            return true
        }
        else {
            return false
        }
    }
    
}
extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfCategory.count
    }

    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            fatalError()
        }
        let category = listOfCategory[indexPath.row]
        cell.categoryImage.image = try? UIImage(withContentsOfUrl: listOfCategory[indexPath.row].strCategoryThumb)
        cell.categoryTitle.text = category.strCategory
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = listOfCategory[indexPath.row].strCategory
        navigationController?.pushViewController(AllMealsOfCategoryViewController(category: category), animated: true)
    }
}
