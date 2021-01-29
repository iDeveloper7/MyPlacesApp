//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Vladimir Karsakov on 27.01.2021.
//

import UIKit
import RealmSwift

class PlaceModel: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    
    let restaurantImage = ["Балкан Гриль", "Бочка", "Вкусные истории", "Дастархан", "Индокитай", "Классик", "Шок", "Bonsai", "Burger Heroes", "Kitchen", "Love&Life", "Morris Pub", "Sherlock Holmes", "Speak Easy", "X.O"]
    
    func savePlaces() {
                
        for place in restaurantImage{
            
            let image = UIImage(named: place)
            guard let imageData = image?.pngData() else { return } //записываем image в формат Data для сохр в realm
            let newPlace = PlaceModel()
            newPlace.name = place
            newPlace.location = "Москва"
            newPlace.type = "Ресторан"
            newPlace.imageData = imageData
            
            StorageManager.saveObject(newPlace)
        }
    }
}
