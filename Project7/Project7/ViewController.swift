//
//  ViewController.swift
//  Project7
//
//  Created by chams on 04/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private var petitions: [Petition] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
        if let url = URL(string: urlString) {
            do {
                let data = try Data(contentsOf: url)
                parse(json: data)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func parse(json: Data) {
        let decoder = JSONDecoder()
        print(json)
        do {
            let jsonPetitions = try decoder.decode(Petitions.self, from: json)
            petitions = jsonPetitions.results
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Title goes here"
        return cell
    }
}

