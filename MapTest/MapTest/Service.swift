//
//  Service.swift
//  MapTest
//
//  Created by C02GC0VZDRJL on 12/17/18.
//  Copyright © 2018 Daniel Monaghan. All rights reserved.
//

import Foundation

class Service {
    
    typealias LocationHandler = ([ArtLocation]) -> Void
    
    static let file = "HonoluluLocations"
    
    class func getLocations(completion: @escaping LocationHandler) {
        // return a list of locations
        
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else { return }
        
        DispatchQueue.global(qos: .userInitiated).async {
            // let data download asynchronously in the background
            
            let url = URL(fileURLWithPath: path)
            
            do {
                
                // convert raw data to JSON object
                let data = try Data(contentsOf: url)
                
                // convert data to JSON object
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                // convert JSON object into array of dictionaries
                guard let objects = json as? [[String:Any]] else {return}
                
                var results: [ArtLocation] = []
                
                // convert dictionaries into custom objects
                for obj in objects {
                    
                    // convert current object to ArtLocation
                    if let location = ArtLocation(json: obj) {
                        
                        // add to result set
                        results.append(location)
                    }
                }
                
                completion(results)
                
            } catch { return }
            
        }
        
        
    }
}
