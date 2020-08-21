//
//  DataManagerMeailDetail.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 21/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import Foundation

func createDetailNewFile(data: [MealDetail]) {
    if let data = try? JSONEncoder().encode(data) {
        FileController().createFile(with: data, name: "DetailsData.Json")
    }
}

func readDetailDataFromFile() -> [MealDetail]? {

    if let data = FileController().retrieveFile(at: "DetailsData.Json") {
        let mealDetails = try? JSONDecoder().decode([MealDetail].self, from: data)
        return mealDetails
    }
    return nil
}

func updateDetailDataFile(data: [MealDetail]) -> Data? {

    if let data = try? JSONEncoder().encode(data) {
        FileController().updateFile(at: "DetailsData.Json", data: data)
        return data
    }
    return nil
}
