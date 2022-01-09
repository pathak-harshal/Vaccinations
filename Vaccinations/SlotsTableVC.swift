//
//  SlotsTableVC.swift
//  Vaccinations
//
//  Created by Harshal Pathak on 09/01/22.
//

import UIKit

class SlotsTableVC: UITableViewController {
    
    static func instantiate() -> SlotsTableVC? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(SlotsTableVC.self)") as? SlotsTableVC
    }
    
    var slots = [String]()
    private var dataSource :TableViewDataSource<SlotDetailsTVC, String>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        updateDataSource()
    }

    private func updateDataSource() {
        self.dataSource = TableViewDataSource(cellIdentifier: Cells.slotCell, items: self.slots) { cell, slot, index in
            
            cell.lblSlot.text = slot
            
        }
        
        self.tableView.dataSource = self.dataSource
        self.tableView.reloadData()
    }
    
}
