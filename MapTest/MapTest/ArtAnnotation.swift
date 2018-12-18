//
//  ArtAnnotation.swift
//  MapTest
//
//  Created by C02GC0VZDRJL on 12/18/18.
//  Copyright © 2018 Daniel Monaghan. All rights reserved.
//

import Foundation
import MapKit

class ArtAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
