//
//  NetworkRequests.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 14/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct NetworkRequest {
    let resourceURL: URL
    
    init() {
        let resourceString = "https://www.themealdb.com/api/json/v1/1/categories.php"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError() }
        self.resourceURL = resourceURL
    }
    init(category: String) {
        let resourceString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError() }
        self.resourceURL = resourceURL
    }
    init(meal: String) {
        let resourceString = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(meal)"
        //print("URL : \(resourceString)")
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    init(area: String) {
        let resourceString = "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(area)"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    init(image: String) {
        let resourceString = image
        
        guard let resourceURL = URL(string: resourceString) else {fatalError() }
        self.resourceURL = resourceURL
    }
    
    func getCategories(session: URLSession = URLSession.shared, completion: @escaping(Result<[Category], NetworkingError>) -> Void) {
        let dataTask = session.dataTask(with: resourceURL, completionHandler: {data, _, _ in
            DispatchQueue.main.async {
                guard let jsonData = data else {
                    completion(.failure(.noDataAvailable))
                    return
                }
                do {
                    let allcategories = try JSONDecoder().decode(AllCategories.self, from: jsonData)
                    let categories = allcategories.categories
                    completion(.success(categories))
                } catch {
                    completion(.failure(.canNotProcessData))
                }
            }
            })
        dataTask.resume()
    }
    
    func getMeals(completion: @escaping(Result<[Meal], NetworkingError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL, completionHandler: {data, _, _ in
            DispatchQueue.main.async {
                guard let jsonData = data else {
                    completion(.failure(.noDataAvailable))
                    return
                }
                do {
                    let allMeals = try JSONDecoder().decode(AllMeals.self, from: jsonData)
                    let meals = allMeals.meals
                    completion(.success(meals))
                } catch {
                    completion(.failure(.canNotProcessData))
                }
            }
            })
        dataTask.resume()
    }
    
    func getMealDetail(completion: @escaping(Result<[MealDetail], NetworkingError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL, completionHandler: {data, _, _ in
            DispatchQueue.main.async {
                guard let jsonData = data else {
                    completion(.failure(.noDataAvailable))
                    return
                }
                do {
                    let mealDetail = try JSONDecoder().decode(Receps.self, from: jsonData)
                    let meals = mealDetail.meals
                    completion(.success(meals))
                } catch {
                    completion(.failure(.canNotProcessData))
                }
            }
            })
        dataTask.resume()
    }
    func getMealforArea(completion: @escaping(Result<[Meal], NetworkingError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL, completionHandler: {data, _, _ in
            DispatchQueue.main.async {
                guard let jsonData = data else {
                    completion(.failure(.noDataAvailable))
                    return
                }
                do {
                    let mealArea = try JSONDecoder().decode(Area.self, from: jsonData)
                    let meals = mealArea.meals
                    completion(.success(meals))
                } catch {
                    completion(.failure(.canNotProcessData))
                }
            }
            })
        dataTask.resume()
    }
    
}
