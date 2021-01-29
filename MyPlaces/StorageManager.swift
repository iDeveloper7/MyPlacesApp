//
//  StorageManager.swift
//  MyPlaces
//
//  Created by Vladimir Karsakov on 29.01.2021.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ place: PlaceModel){
        try! realm.write{
            realm.add(place)
        }
    }
}
