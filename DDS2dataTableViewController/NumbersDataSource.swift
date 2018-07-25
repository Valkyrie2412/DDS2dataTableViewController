//
//  NumbersDataSource.swift
//  DDS2dataTableViewController
//
//  Created by Hiếu Nguyễn on 7/17/18.
//  Copyright © 2018 Hiếu Nguyễn. All rights reserved.
//

import UIKit

class NumbersDataSource: NSObject, UITableViewDataSource {
    var numbersData: TableViewController?
    var numbers = [1, 2, 3]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(numbers[indexPath.row])
        return cell
    }
    
    
            // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
                if editingStyle == .delete {
                    numbers.remove(at: indexPath.row)
                    // Delete the row from the data source
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    numbersData?.hasNodata = (numbers.count == 0)
                } else if editingStyle == .insert {
                    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
                }
            }
    
    
}
