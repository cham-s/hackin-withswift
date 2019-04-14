//
//  Person.swift
//  Project10
//
//  Created by chams on 11/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit

class Person: NSObject {
    public var name: String
    public var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
