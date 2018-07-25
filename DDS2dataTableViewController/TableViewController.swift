//
//  TableViewController.swift
//  DDS2dataTableViewController
//
//  Created by Hiếu Nguyễn on 7/17/18.
//  Copyright © 2018 Hiếu Nguyễn. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let numbersDaTaSource = NumbersDataSource()
    let wordsDataSource = WordsDataSource()
    let numbersDelegate = NumbersDelegate()
    
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var nodataView: UIView!
    @IBOutlet weak var switchData: UISwitch!
    var hasNodata : Bool = true {
        didSet {
            hasNodata ? (tableView.tableFooterView = nodataView) : (tableView.tableFooterView = footerView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = numbersDaTaSource
        numbersDaTaSource.numbersData = self
        wordsDataSource.wordsData = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeData(_ sender: UISwitch) {
        if sender .isOn {
            tableView.dataSource = numbersDaTaSource
            hasNodata = (numbersDaTaSource.numbers.count == 0)
        } else {
            tableView.dataSource = wordsDataSource
            hasNodata = (wordsDataSource.words.count == 0)
        }
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController {
            if let textIndex = tableView.indexPathForSelectedRow {
                if switchData.isOn {
                    viewController.data = String(numbersDaTaSource.numbers[textIndex.row])
                } else{
                    viewController.data = wordsDataSource.words[textIndex.row]
                }
            }
        }
    }
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        guard let detailVC = unwindSegue.source as? ViewController else {return}
        if let indexPath = tableView.indexPathForSelectedRow {
            if switchData.isOn {
                numbersDaTaSource.numbers[indexPath.row] = Int(detailVC.data ?? "") ?? 0
            } else {
                wordsDataSource.words[indexPath.row] = detailVC.data ?? ""
            }
            tableView.reloadData()
        } else {
            if switchData.isOn {
                numbersDaTaSource.numbers.append (Int(detailVC.data ?? "") ?? 0 )
                hasNodata = (numbersDaTaSource.numbers.count == 0)
            } else {
                wordsDataSource.words.append(detailVC.data ?? "")
                hasNodata = (wordsDataSource.words.count == 0)
            }
        }
        tableView.reloadData()
    }
}
// viet gon ham if else


//if let index = tableView.indexPathForSelectedRow?.row {
//    switchData.isOn ?  ( numberDataSource.number[index] = Int(viewcontroller.name)!) : ( stringDataSource.string[index] = viewcontroller.name)
//}else{
//    switchData.isOn ? (numberDataSource.number.append(Int(viewcontroller.name)!)) : ( stringDataSource.string.append(viewcontroller.name))
//
//
//}
