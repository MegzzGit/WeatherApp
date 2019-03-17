//
//  Constants.swift
//  WeatherApp
//
//  Created by Admin on 3/15/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

    typealias DownloadComplete = () -> ()
    var longitude = "50"
    var latitude = "30"
    let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=9fb8561eba588e0b32805a7b93ba3277"
    let FORCAST_WEATHER_URL = "http://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=9fb8561eba588e0b32805a7b93ba3277"



