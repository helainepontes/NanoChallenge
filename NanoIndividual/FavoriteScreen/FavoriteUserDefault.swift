//
//  FavoriteUserDefault.swift
//  NanoIndividual
//
//  Created by Helaine Pontes on 20/08/20.
//  Copyright © 2020 Helaine Pontes. All rights reserved.
//

import Foundation
import UIKit

class Persistence {
    let defaults = UserDefaults.standard
    var objects = [String]()
    private var key = "Favoritos"

    init() {
        let decoder = JSONDecoder()
        if let data = defaults.value(forKey: key) as? Data {
            do {
                let taskData = try decoder.decode([String].self, from: data)
                self.objects = taskData
            } catch {
                print("Deu merda no init: \(error.localizedDescription)")
            }
        }
    }
    
    func removeAll() {
        objects.removeAll()
        save()
    }

    func add(object: String) {
        print(objects)
        if !existObjetc(object: object) {
            objects.append(object)
        }
        save()
    }
    
    func removeObject(index: Int) {
        objects.remove(at: index)
        save()
    }
    
    func existObjetc(object: String) -> Bool {
        self.objects.contains(object) == true ? true:false
    }
    
    func persistedObjects() -> [String] {
        var persistedObjects = [String]()
        let decoder = JSONDecoder()
        if let data = defaults.value(forKey: key) as? Data {
            do {
                let taskData = try decoder.decode([String].self, from: data)
                persistedObjects = taskData
            } catch {
                print("Error load persisted objects: \(error.localizedDescription)")
            }
        }
        return persistedObjects.count == 0 ? [] : persistedObjects
    }

    func save() {
        let enconder = JSONEncoder()
        do {
            let data = try enconder.encode(objects)
            defaults.set(data, forKey: key)
        } catch {
            print("Deu merda no save: \(error.localizedDescription)")
        }
    }
}
