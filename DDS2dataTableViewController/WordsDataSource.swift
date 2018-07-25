//
//  WordsDataSource.swift
//  DDS2dataTableViewController
//
//  Created by Hiếu Nguyễn on 7/17/18.
//  Copyright © 2018 Hiếu Nguyễn. All rights reserved.
//

import UIKit

class WordsDataSource: NSObject, UITableViewDataSource {
    var wordsData: TableViewController?
    var words = ["Ha Noi", "Ho Chi Minh", "Da Nang"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = words[indexPath.row]
        return cell
    }
    
            // Override to support editing the table view.
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
                if editingStyle == .delete {
                    // Delete the row from the data source
                    words.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    wordsData?.hasNodata = (words.count == 0)
                } else if editingStyle == .insert {
                    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
                }
            }
    
}
