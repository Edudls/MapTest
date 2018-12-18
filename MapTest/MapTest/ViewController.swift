//
//  ViewController.swift
//  MapTest
//
//  Created by C02GC0VZDRJL on 12/17/18.
//  Copyright © 2018 Daniel Monaghan. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var text: String = ""
    var locations = [ArtLocation]()
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // ask before diplaying user's location on the map
        self.getLocation()
        
        //self.mapView.showsUserLocation = true
        
        // actually get the locations to display on the map
        Service.getLocations() {locations in
            
            // save the locations to a var
            self.locations = locations
            
            // create and display the text for the latitudes and longitudes we got
            for location in locations {
                self.text.append("latitude: " + location.latitude + ", longitude: " + location.longitude + "\n")
            }
            
            self.textLabel.text = "Got art locations\n" + self.text
            
            self.addLocations(at: locations)
            
        }
    }
    
    
    func getLocation() {
        
        // ask for location authorization when app is in use. will only ask once.
        manager.requestWhenInUseAuthorization()
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // shows the user's location if the app is authorized to use it
            
            self.mapView.showsUserLocation = true
            
            let location = manager.location
            zoom(to: location!)
            
        } else {
            return
        }
        
        /*if let location = self.manager.location {
            // if we have user's location, zoom in to it
            zoom(to: location)
        } else {
            // if not, request the location
            self.manager.requestWhenInUseAuthorization()
        }*/
    }
    
    
    func addLocations(at locations: [ArtLocation]) {
        for location in locations {
            let coordinates = CLLocationCoordinate2DMake(Double(location.latitude)!, Double(location.longitude)!)
            let annotation = ArtAnnotation(coordinate: coordinates)
            DispatchQueue.main.async {
                self.mapView.addAnnotation(annotation)
            }
        }
    }

}

extension ViewController: CLLocationManagerDelegate {
    
    // user location changed
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("User location updated")
        
        // get the first location returned
        guard let location = locations.first else {return}
        
        zoom(to: location)
        
    }
    
    
    func zoom(to location: CLLocation) {
        
        /*let span = MKCoordinateSpan(latitudeDelta: location.coordinate.latitude, longitudeDelta: location.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        
        mapView.setRegion(region, animated: true)*/
        
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000)
        
        mapView.setRegion(region, animated: true)
        
        
    }
}

