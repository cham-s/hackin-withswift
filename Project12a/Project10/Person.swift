//
//  Person.swift
//  Project10
//
//  Created by chams on 11/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
    public var name: String
    public var image: String
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        image = aDecoder.decodeObject(forKey: "image") as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
