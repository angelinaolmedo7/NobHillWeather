//
//  FirstViewController.swift
//  NobHillWeather
//
//  Created by Angelina Olmedo on 6/8/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var networkManager = NetworkManager()
    private var weather: WeatherResponse! {
        didSet {
            setUpDisplay()
        }
    }
    var logs: [LogItem] = []
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var moodBox: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        clearLogs()
        fetchWeather()
        retrieveLogs()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        fetchWeather()
    }

    func fetchWeather() {
        networkManager.getWeather() { result in
            switch result {
            case let .success(weather):
                self.weather = weather
            case let .failure(error):
              print(error)
            }
        }
    }
    
    func setUpDisplay() {
        let fTemp = Double(round(100*(Main.kelvinToF(kel: (weather.main?.temp)!)))/100) // round to 2 decimal places
        self.tempLabel.text = "\(fTemp)°F"
        self.detailsLabel.text = "\(weather.weather[0]?.main ?? "ERROR") // \(weather.main?.humidity ?? 0)% humidity"
    }

    @IBAction func submitPressed(_ sender: Any) {
        let newLogItem = LogItem(mood: moodBox.text, weather: self.weather)
        logs.append(newLogItem)
        saveLogs()
        self.moodBox.text = ""
    }
    
    func saveLogs() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(logs) {
            do {
                try encoded.write(to: URL(fileURLWithPath: LogItem.ArchiveURL.path))
            }
            catch {
                print("Could not save to file.")
            }
        }
    }
    
    func retrieveLogs() {
        do {
            let savedData = try Data.init(contentsOf: URL(fileURLWithPath: LogItem.ArchiveURL.path))
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([LogItem].self, from: savedData) {
                logs = decoded
            }
        }
        catch {
            print("Could not retrieve data from file.")
        }
    }
    
    func clearLogs() {
        self.logs = []
        saveLogs()
    }
    
}

