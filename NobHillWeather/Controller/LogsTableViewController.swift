//
//  TableViewController.swift
//  NobHillWeather
//
//  Created by Angelina Olmedo on 6/12/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import UIKit

class LogsTableViewController: UITableViewController {
    
    var logs: [LogItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
                    LogTableViewCell.nib,
                    forCellReuseIdentifier: LogTableViewCell.identifier
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retrieveLogs()
        self.tableView.reloadData()
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: LogTableViewCell.identifier, for: indexPath) as! LogTableViewCell
        // Configure the cell...
        cell.setCell(log: logs[indexPath.row])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
