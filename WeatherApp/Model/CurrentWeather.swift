//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Admin on 3/15/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    var _cityName: String!
    var _weatherType: String!
    var _date: String!
    var _currentTemp: Double!
    var test: Double = 5
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
            }
        return _cityName
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .long
        dateformatter.timeStyle = .none
        let currentDate = dateformatter.string(from: Date())
        self._date = currentDate
        return _date
    }
    
    func downloadWeatherData(completed: @escaping DownloadComplete){
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON{
            response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                    }
                }
                
                if let cityName = dict["name"] as? String{
                    self._cityName = cityName.capitalized
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject>{
                    if let temp = main["temp"] as? Double{
                        let tempCalculated = round(temp - 273.15)
                        self._currentTemp = tempCalculated
                        self.test = tempCalculated
                    }
                }
            }
            completed()
        }
    }
}




