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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hasNodata = switchData.isOn ? (numbersDaTaSource.numbers.count == 0) : (wordsDataSource.words.count == 0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeData(_ sender: UISwitch) {
        sender.isOn ? (tableView.dataSource = numbersDaTaSource) : (tableView.dataSource = wordsDataSource)
        sender.isOn ? (hasNodata = (numbersDaTaSource.numbers.count == 0)) : (hasNodata = (wordsDataSource.words.count == 0))
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController {
            if let textIndex = tableView.indexPathForSelectedRow {
                viewController.data = switchData.isOn ? (String(numbersDaTaSource.numbers[textIndex.row])) : (wordsDataSource.words[textIndex.row])
            }
        }
    }
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        guard let detailVC = unwindSegue.source as? ViewController else {return}
        if let indexPath = tableView.indexPathForSelectedRow {
            switchData.isOn ? (numbersDaTaSource.numbers[indexPath.row] = Int(detailVC.data ?? "") ?? 0) : (wordsDataSource.words[indexPath.row] = detailVC.data ?? "")
            tableView.reloadData()
        } else {
            switchData.isOn ? (numbersDaTaSource.numbers.append(Int(detailVC.data ?? "") ?? 0)) : (wordsDataSource.words.append(detailVC.data ?? ""))
        }
        tableView.reloadData()
    }
}

