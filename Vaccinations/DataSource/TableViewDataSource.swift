//
//  TableViewDataSource.swift
//  Vaccinations
//
//  Created by Harshal Pathak on 08/01/22.
//

import Foundation
import UIKit

class TableViewDataSource<Cell :UITableViewCell,ViewModel> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier :String!
    private var items :[ViewModel]!
    var configureCell :(Cell,ViewModel) -> ()
    
    init(cellIdentifier :String, items :[ViewModel], configureCell: @escaping (Cell,ViewModel) -> ()) {
        
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        let item = self.items[indexPath.row]
        self.configureCell(cell,item)
        return cell
    }
    
}
