//
//  Location.swift
//  Uber Clone
//
//  Created by Wei Chu on 2022/10/19.
//

import Foundation
import CoreLocation

struct Location{
    
    let title:String
    let coordinates:CLLocationCoordinate2D
    
}

class LocationManager:NSObject {
    
    static let shared = LocationManager()
    
    public func findLocation(with query:String, completion: @escaping (([Location]) -> Void)){
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(query) { places, error in
            guard let places = places, error == nil else {
                completion([])
                return}
            
            let models:[Location] = places.compactMap ({ place  in
                var name = ""
                
                if let locationName = place.name{
                    name += locationName
                }
                
                if let adminRegion = place.administrativeArea{
                    name += ", \(adminRegion)"
                }
                
                if let locality = place.locality{
                    name += ", \(locality)"
                }

                if let country = place.country{
                    name += ", \(country)"
                }

                print("\n\(place)\n\n")
                
                let result = Location(title: name, coordinates: place.location?.coordinate ?? CLLocationCoordinate2D())
                
                return result
            })
            
            completion(models)
        }
        
    }
    
}
