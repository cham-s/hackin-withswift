//
//  Capital.swift
//  Project19
//
//  Created by chams on 25/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    public var title: String?
    public var coordinate: CLLocationCoordinate2D
    public var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D,
         info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
}
