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
    private var currentWord: [Character] = []
    private var usedLetter: [Character] = []
    private var finalText: [Character] = [] {
        didSet {
            wordLabel.text = String(finalText)
        }
    }
    private var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    private var chances = 7 {
        didSet {
            chancesLabel.text = "Chances: \(chances)"
            
        }
    }
    
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var chancesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose,
                                                            target: self,
                                                            action: #selector(composeLetter))
        
        if let startWordsPath = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let content = try? String(contentsOfFile: startWordsPath) {
                words = content.components(separatedBy: "\n")
            } else {
                words = ["shoes"]
            }
        } else {
            words = ["shoes"]
        }
        startGame()
    }
    
    private func startGame() {
        currentWord = Array(words.randomElement()!)
        usedLetter.removeAll(keepingCapacity: true)
        finalText = Array(repeating: "?", count: currentWord.count)
        score = 0
        print(currentWord)
        
    }
    
    private func errorlength() {
        let ac = UIAlertController(title: "Letter Count",
                                   message: "It should have ony one Letter",
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Retry", style: .cancel))
        present(ac, animated: true)
    }
    
    private func endGame(win: Bool) {
        
    }
    
    private func submit(answer: String) {
        let char = answer.first!
        var hasChanged = false
        
        for i in currentWord.indices {
            if currentWord[i] == char {
                finalText[i] = char
                hasChanged = true
            }
        }
        if !hasChanged {
            chances -= 1
            
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

