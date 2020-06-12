//
//  LogTableViewCell.swift
//  NobHillWeather
//
//  Created by Angelina Olmedo on 6/12/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import UIKit

class LogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    static var identifier: String = "LogCell"

    static var nib: UINib {
           return UINib(nibName: String(describing: self), bundle: nil)
    }

    func setCell(log: LogItem!) {
        self.moodLabel.text = log.mood!
        self.dateLabel.text = log.date!
        self.weatherLabel.text = log.weatherString!
    }
    
}
