//
//  Location.swift
//  WeatherApp
//
//  Created by Admin on 3/18/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import CoreLocation

class Location {
    
    static var sharedInstance = Location()
    private init() {}
    
    var longitude: Double!
    var latitude: Double!
    
    
}

