//
//  ViewController.swift
//  Challenge3
//
//  Created by chams on 08/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private var items: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    @objc private func addItem() {
        let ac = UIAlertController(title: "Add Item", message: "Please input the item name",
                                   preferredStyle: .actionSheet)
        ac.addTextField()
    }
    
}

