//
//  ViewController.swift
//  Challenge4
//
//  Created by chams on 08/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var words: [String] = []
    private var currentWord = ""
    private var usedLetter: [Character] = []
    private var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                            target: self,
                                                            action: #selector(composeLetter))
        
        if let startWords = Bundle.main.path(forResource: "start", ofType: "txt") {
            words = startWords.components(separatedBy: "\n")
        } else {
            words = ["shoes"]
        }
    }
    
    private func startGame() {
        currentWord = words.randomElement()!
        usedLetter.removeAll(keepingCapacity: true)
        wordLabel.text = String(repeating: "?", count: currentWord.count)
        score = 0
        
    }
    
    private func errorlength() {
        let ac = UIAlertController(title: "Letter Count",
                                   message: "It should have ony one Letter",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Retry", style: .cancel))
        present(ac, animated: true)
    }
    
    private func submit(answer: String) {
        let char = answer[0]
        if currentWord.firstIndex(of: char) {
            wordLabel.text?.replacingOccurrences(of: :, with: <#T##StringProtocol#>)
        }
    }
    
    @objc private func composeLetter() {
        let ac = UIAlertController(title: "Letter",
                                   message: "Please input a letter",
                                   preferredStyle: .alert)
        ac.addTextField()
        let submissionAction = UIAlertAction(title: "Try", style: .default) { [unowned self, ac] (action: UIAlertAction) in
            let letter = ac.textFields![0].text!
            guard letter.count == 1 else {
                self.errorlength()
                return
            }
            self.submit(answer: letter)
        }
        ac.addAction(submissionAction)
        present(ac, animated: true)
    }
}

