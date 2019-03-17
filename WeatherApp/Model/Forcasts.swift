//
//  Forcasts.swift
//  WeatherApp
//
//  Created by Admin on 3/16/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Alamofire

class Forcasts {
    
    var _weatherType: String!
    var _date: String!
    var _highTemp: Double!
    var _lowTemp: Double!
   
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: Double {
        if _highTemp == nil {
            _highTemp = 0.0
        }
        return _highTemp
    }
    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        return _lowTemp
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        if let main = weatherDict["main"] as? Dictionary<String, AnyObject> {
            if let min = main["temp_min"] as? Double {
                let minTempCalculated = round(min - 273.15)
                self._lowTemp = minTempCalculated
            }
            if let max = main["temp_max"] as? Double {
                let maxTempCalculated = round(max - 273.15)
                self._highTemp = maxTempCalculated
            }
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            self._date = unixConvertedDate.DayOfTheWeek()
        }
    }
    init(duplicator: Forcasts) {
        self._date = duplicator.date
        self._lowTemp = duplicator.lowTemp
        self._highTemp = duplicator.highTemp
        self._weatherType = duplicator.weatherType
    }
    init() { }
    
    
}

extension Date {
    func DayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}









