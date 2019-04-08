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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForItem))
        
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item",
                                                 for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    private func submit(item: String) {
        let indexPath = IndexPath(row: 0, section: 0)
        items.insert(item, at: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    
    @objc private func promptForItem() {
        let ac = UIAlertController(title: "Add Item", message: "Please input the item name",
                                   preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Add",
                                         style: .default) { [unowned self, ac] (action: UIAlertAction) in
            let item = ac.textFields![0]
            self.submit(item: item.text!)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
}

