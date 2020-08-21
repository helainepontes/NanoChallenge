//
//  DataManager.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 21/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import Foundation

func createMealNewFile(data: [Meal]) {
    if let data = try? JSONEncoder().encode(data) {
        FileController().createFile(with: data, name: "MeailData.Json")
    }
}

func readMealDataFromFile() -> [Meal]? {

    if let data = FileController().retrieveFile(at: "MeailData.Json") {
        let allmeals = try? JSONDecoder().decode([Meal].self, from: data)
//        let meals = allmeals?.meals
        return allmeals
    }
    return nil
}

func updateMealDataFile(data: [Meal]) -> Data? {

    if let data = try? JSONEncoder().encode(data) {
        FileController().updateFile(at: "MeailData.Json", data: data)
        return data
    }
    return nil
}
