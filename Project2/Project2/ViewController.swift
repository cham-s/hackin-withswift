//
//  ViewController.swift
//  Project2
//
//  Created by chams on 30/03/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    private var buttons: [UIButton] {
        return [button1, button2, button3]
    }
    
    public var countries: [String] = []
    public var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    public var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland",
                      "italy", "monaco", "nigeria", "poland", "russia", "spain",
                      "uk", "us"]
        buttons.forEach { $0.layer.borderWidth = 1 }
        buttons.forEach { $0.layer.borderColor = UIColor.lightGray.cgColor }
        askQuestion()
        
        // Do any additional setup after loading the view.
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        let ac = UIAlertController(title: title,
                                   message: "You Are \(title)",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: askQuestion))
        present(ac, animated: true)
    }
}

