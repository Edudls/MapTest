//
//  JSONLocation.swift
//  MapTest
//
//  Created by C02GC0VZDRJL on 12/17/18.
//  Copyright © 2018 Daniel Monaghan. All rights reserved.
//

import Foundation

struct ArtLocation {
    
    let latitude: String
    let longitude: String
    
    init?(json: [String: Any]) {
        
        guard let lat = json["latitude"] as? String else { return nil }
        guard let lon = json["longitude"] as? String else { return nil }
        
        self.latitude = lat
        self.longitude = lon
        
    }
}
