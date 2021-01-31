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
    
    convenience init(name: String, location: String?, type: String?, imageData: Data?){
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
}
