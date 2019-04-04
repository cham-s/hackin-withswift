//
//  ViewController.swift
//  Project6b
//
//  Created by chams on 04/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.red
        label1.text = "THESE"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        let labels = [label1, label2, label3, label4, label5]
        
        labels.forEach { view.addSubview($0) }
        
        let viewDictionary = [
            "label1": label1,
            "label2": label2,
            "label3": label3,
            "label4": label4,
            "label5": label5
        ]
        
        let metrics = ["labelHeight": 88]
        
        viewDictionary.forEach { label in
            view.addConstraints(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[\(label.key)]|",
                options: [],
                metrics: nil,
                views: viewDictionary))
        }
        
//        let visualFormat = "V:|" + viewDictionary.keys
//                        .map { "[\($0)(labelHeight)]" }.sorted().joined(separator: "-") +
//                        "-(>=10)-|"
        
        let visualFormat = "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|"
        
        
        view.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: visualFormat,
            options: [],
            metrics: metrics,
            views: viewDictionary))
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

