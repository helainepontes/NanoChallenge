//
//  DataManagerCategories.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 21/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import Foundation

func createCategoryNewFile(data: [Category]) {
    if let data = try? JSONEncoder().encode(data) {
        FileController().createFile(with: data, name: "CategoriesData.Json")
    }
}

func readCategoryDataFromFile() -> [Category]? {

    if let data = FileController().retrieveFile(at: "CategoriesData.Json") {
        let categories = try? JSONDecoder().decode([Category].self, from: data)
//        let meals = allmeals?.meals
        return categories
    }
    return nil
}

func updateCategoryDataFile(data: [Category]) -> Data? {

    if let data = try? JSONEncoder().encode(data) {
        FileController().updateFile(at: "CategoriesData.Json", data: data)
        return data
    }
    return nil
}
