//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Admin on 3/14/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var weathertypeicon: UIImageView!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forcastArr = [Forcasts]()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    var highTempDaily: Double! = 0.0
    var lowTempDaily: Double! = 0.0
    var day: String! = ""
    var dailyForcast: Forcasts!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        currentWeather = CurrentWeather()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            
            currentWeather.downloadWeatherData{
                self.DownloadForcastsData {
                    self.updateMainUI()
                }
            }
            
        }else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    
    func DownloadForcastsData(completed: @escaping DownloadComplete){
        /////
        Alamofire.request(FORCAST_WEATHER_URL).responseJSON{
            response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    
                    self.dailyForcast = Forcasts()
                    
                    for obj in list {

                        let forcasts = Forcasts(weatherDict: obj)
                        
                        if self.day  != ""{
                            if self.day != forcasts.date {
                                
                                self.dailyForcast._highTemp = self.highTempDaily
                                self.dailyForcast._lowTemp = self.lowTempDaily
                                let dailyForcastInst = Forcasts(duplicator: self.dailyForcast)
                                self.forcastArr.append(dailyForcastInst)
                                
                                self.highTempDaily = forcasts._highTemp
                                self.lowTempDaily = forcasts._lowTemp
                                self.dailyForcast._date = forcasts.date
                                self.dailyForcast._weatherType = forcasts.weatherType
                                self.day = forcasts.date
                                
                            }else {
                                
                                if forcasts.highTemp > self.highTempDaily {
                                    self.highTempDaily = forcasts.highTemp
                                }
                                if forcasts.lowTemp < self.lowTempDaily {
                                    self.lowTempDaily = forcasts.lowTemp
                                }
                                
                            }
                        }else {

                            self.highTempDaily = forcasts.highTemp
                            self.lowTempDaily = forcasts.lowTemp
                            self.day = forcasts.date
                            
                            self.dailyForcast._date = forcasts.date
                            self.dailyForcast._weatherType = forcasts.weatherType
                        }
                    }
                    self.dailyForcast._highTemp = self.highTempDaily
                    self.dailyForcast._lowTemp = self.lowTempDaily
                    let dailyForcastInst = Forcasts(duplicator: self.dailyForcast)
                    self.forcastArr.append(dailyForcastInst)
                    
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forcastArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forcasts = forcastArr[indexPath.row]
            cell.ConfigureCell(forcasts: forcasts)
            return cell
        }else {
            return WeatherCell()
        }
    }
    
    
    func updateMainUI(){
        
            dateLbl.text = currentWeather.date
            cityLbl.text = currentWeather.cityName
            weatherTypeLbl.text = currentWeather.weatherType
            tempLbl.text = "\(currentWeather.currentTemp)"
            weathertypeicon.image = UIImage(named: currentWeather.weatherType)
    }
    
    
}







