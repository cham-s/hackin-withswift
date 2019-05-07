//
//  ViewController.swift
//  Project32
//
//  Created by chams on 06/05/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var projects: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        projects.append(["Project 1: Storm Viewer", "Constants and variables, UITableView, UIImageView, FileManager, storyboards"])
            projects.append(["Project 2: Guess the Flag", "@2x and @3x images, asset catalogs, integers, doubles, floats, operators (+= and -=), UIButton, enums, CALayer, UIColor, random numbers, actions, string interpolation, UIAlertController"])
            projects.append(["Project 3: Social Media", "UIBarButtonItem,UIActivityViewController, the Social framework, URL"])
            projects.append(["Project 4: Easy Browser", "loadView(), WKWebView, delegation, classes and structs, URLRequest, UIToolbar, UIProgressView., key-value observing"])
            projects.append(["Project 5: Word Scramble", "Closures, method return values, booleans, NSRange"])
            projects.append(["Project 6: Auto Layout", "Get to grips with Auto Layout using practical examples and code"])
            projects.append(["Project 7: Whitehouse Petitions", "JSON, Data, UITabBarController"])
            projects.append(["Project 8: 7 Swifty Words", "addTarget(), enumerated(), count, index(of:), property observers, range operators."])
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath)
        let project = projects[indexPath.row]
        cell.textLabel?.text = "\(project[0]): \(project[1])"
        
        return cell
    }
    
}

