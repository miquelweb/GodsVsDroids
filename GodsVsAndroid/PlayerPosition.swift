//
//  PlayerPosition.swift
//  GodsVsAndroid
//
//  Created by Miquel Viladomat on 4/11/16.
//  Copyright © 2016 Miquel Viladomat. All rights reserved.
//

import UIKit

import MapKit
class PlayerPosition: NSObject,MKAnnotation {
    
        var title: String?
        var subtitle: String?
        var latitude: Double
        var longitude:Double
        var no:Int
    
        var coordinate: CLLocationCoordinate2D {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
    init(latitude: Double, longitude: Double, no:Int) {
            self.latitude = latitude
            self.longitude = longitude
            self.no = no
    }
    
   
}
