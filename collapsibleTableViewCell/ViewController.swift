//
//  ViewController.swift
//  collapsibleTableViewCell
//
//  Created by Aaron Chambers on 2017-03-12.
//  Copyright © 2017 AaronChambers. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //The amount of cells -- all the data
    var testArray1 = 5
    var testArray2 = 2
    var testArray3 = 5
    
    var copyArray1 = 5
    var copyArray2 = 2
    var copyArray3 = 5
    //---------------------------------
    
    //Place in the table view to insert/delete the cells
    var copyIndex1 = [IndexPath]()
    var copyIndex2 = [IndexPath]()
    var copyIndex3 = [IndexPath]()
    
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.dataSource = self
        tb.delegate = self
        tb.backgroundColor = .red
        return tb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tb")
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(tableView)
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tb", for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            cell.backgroundColor = .orange
        }else{
          cell.backgroundColor = .blue
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //Getting the total amount of items in the section
            let itemsToRemove = (tableView.numberOfRows(inSection: indexPath.section)) - 1
            print(itemsToRemove)
            //Checking if the cell was already collapsed
            if itemsToRemove == 0{
                tableView.beginUpdates()
                //Copy of the coordinates of the cells
                var copyArray = [IndexPath]()
                //Checking which section was clicked
                switch indexPath.section{
                case 0:
                    testArray1 = copyArray1
                    copyArray = copyIndex1
                case 1:
                    testArray2 = copyArray2
                    copyArray = copyIndex2
                case 2:
                    testArray3 = copyArray3
                    copyArray = copyIndex3
                default: break
                }
                //Inserting cells at the coordinates
                tableView.insertRows(at: copyArray, with: .bottom)
                tableView.endUpdates()
            }else{
            //coordinates array
            var array = [IndexPath]()
            //Using for loop to get all the adresses then adding them to the array
            for index in 1...itemsToRemove{
                let indexPath = NSIndexPath(row: index, section: indexPath.section)
                array.append(indexPath as IndexPath)
            }
            //Checking which section was clicked then adding them to the designated section
                switch indexPath.section {
                case 0:
                    copyIndex1 = array
                case 1:
                    copyIndex2 = array
                case 2:
                    copyIndex3 = array
                default: break
                }
            print(array)
            tableView.beginUpdates()
                //Updationg the number of rows in setion
                switch indexPath.section{
                case 0:
                    testArray1 = testArray1 - array.count
                case 1:
                    testArray2 = testArray2 - array.count
                case 2:
                    testArray3 = testArray3 - array.count
                default: break
                }
            tableView.deleteRows(at:array , with: UITableViewRowAnimation.top)
            tableView.endUpdates()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return testArray1
        case 1:
            return testArray2
        case 2:
            return testArray3
        default:
            return 7
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    

    
    
    

}

