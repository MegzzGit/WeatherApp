//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Admin on 3/17/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var WeatherIcon: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherTypeLbl: UILabel!
    @IBOutlet weak var highTempLbl: UILabel!
    @IBOutlet weak var lowTempLbl: UILabel!
    

    func ConfigureCell(forcasts: Forcasts){
        
        dayLbl.text = forcasts.date
        weatherTypeLbl.text = forcasts.weatherType
        highTempLbl.text = "\(forcasts.highTemp)°"
        lowTempLbl.text = "\(forcasts.lowTemp)°"
        WeatherIcon.image = UIImage(named: "\(forcasts.weatherType) Mini" )
        let image = UIImage(named: forcasts.date )
        self.backgroundView = UIImageView(image: image)
    }


}
