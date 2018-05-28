//
//  CategoryPickerViewController.swift
//  MyLocations
//
//  Created by Nguyen Van An on 28/05/2018.
//  Copyright © 2018 An. All rights reserved.
//

import UIKit

protocol CategoryPickerViewControllerDelegate: class {
    func CategoryPickerViewController(_ controller: CategoryPickerViewController, didFinishPicking item: String )  
}


class CategoryPickerViewController: UITableViewController {
    
    weak var delegate: CategoryPickerViewControllerDelegate?
    var selectedCatergoryName = ""
    
    let categories = [
        "No Category",
        "Apple Store",
        "Bar",
        "Bookstore",
        "Club",
        "Grocery Store",
        "Historic Building",
        "House",
        "Icecream Vendor",
        "Landmark",
        "Park"]
    
    var selectedIndexPath = IndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<categories.count {
            if categories[i] == selectedCatergoryName {
                selectedIndexPath = IndexPath(row: i, section: 0)
                break
            }
        }
    }
    
    @IBAction func done() {
        delegate?.CategoryPickerViewController(self, didFinishPicking: selectedCatergoryName)
    }

 

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let categoryName = categories[indexPath.row]
        cell.textLabel!.text = categoryName
        
        if categoryName == selectedCatergoryName {
            cell.accessoryType = .checkmark
            
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != selectedIndexPath.row {
            if let newCell = tableView.cellForRow(at: indexPath) {
                newCell.accessoryType = .checkmark
                selectedCatergoryName = categories[indexPath.row]
            }
            if let oldCell = tableView.cellForRow(at: selectedIndexPath) {
                oldCell.accessoryType = .none
            }
            selectedIndexPath = indexPath
        }
    }



}
