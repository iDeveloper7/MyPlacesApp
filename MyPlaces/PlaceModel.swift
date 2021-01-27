//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Vladimir Karsakov on 27.01.2021.
//

import Foundation

struct PlaceModel {
    
    var name: String
    var location: String
    var type: String
    var image: String
    
    static let restaurantNames = ["Балкан Гриль", "Бочка", "Вкусные истории", "Дастархан", "Индокитай", "Классик", "Шок", "Bonsai", "Burger Heroes", "Kitchen", "Love&Life", "Morris Pub", "Sherlock Holmes", "Speak Easy", "X.O"]
    
    static func getPlaces() -> [PlaceModel]{
        
        var places = [PlaceModel]()
        
        for place in restaurantNames{
            places.append(PlaceModel(name: place, location: "Уфа", type: "Ресторан", image: place))
        }
        return places
    }
    
    
}
