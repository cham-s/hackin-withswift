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
        
        performSelector(inBackground: #selector(fetchJSON),
                        with: nil)
    }
    
    @objc func fetchJSON() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        
        if let url = URL(string: urlString) {
            do {
                let data = try Data(contentsOf: url)
                parse(json: data)
                return
            } catch {
                print(error.localizedDescription)
                return
            }
        }
        performSelector(onMainThread: #selector(showError),
                        with: nil,
                        waitUntilDone: false)

    }
    
    @objc private func showError() {
        DispatchQueue.main.async { [unowned self] in
            let ac = UIAlertController(title: "Loading error",
                                       message: "Problem",
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
    
    private func parse(json: Data) {
        let decoder = JSONDecoder()
        do {
            let jsonPetitions = try decoder.decode(Petitions.self, from: json)
            petitions = jsonPetitions.results
            
            performSelector(onMainThread: #selector(UITableView.reloadData),
                            with: nil,
                            waitUntilDone: false)
            return
        } catch {
            performSelector(onMainThread: #selector(showError),
                            with: nil,
                            waitUntilDone: false)
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
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

