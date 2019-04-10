//
//  ViewController.swift
//  Challenge4
//
//  Created by chams on 08/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    private var words: [String] = []
    private var currentWord: [Character] = []
    private var usedLetter: [Character] = [] {
        didSet {
            if usedLetter.count == currentWord.count {
                endGame(win: true)
            }
        }
    }
    private var usedWords: [String] = []
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
            print("chances left: \(chances)")
            chancesLabel.text = "Chances: \(chances)"
            if chances == 0 {
                endGame(win: false)
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var chancesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
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
        nextWord()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        
        return cell
    }
    
    private func nextWord(action: UIAlertAction? = nil) {
        currentWord = Array(words.randomElement()!)
        usedLetter.removeAll(keepingCapacity: true)
        finalText = Array(repeating: "?", count: currentWord.count)
        chances = 7
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
        let message: String
        let title: String
        
        if win {
            title = "Great!"
            message = "Congratulations! let get to the next word."
            score += 10
            usedWords.insert(String(currentWord), at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        } else {
            title = "Toob bad"
            message = "Let's move to the next word."
            score -= 5
        }
        let ac = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK",
                                   style: .default,
                                   handler: nextWord))
        present(ac, animated: true)
    }
    
    private func submit(answer: String) {
        let char = answer.first!
        var hasChanged: Bool? = nil
        
        for i in currentWord.indices {
            if currentWord[i] == char {
                finalText[i] = char
                usedLetter.append(currentWord[i])
                if hasChanged == nil {
                    hasChanged = true
                }
            }
        }
        if hasChanged == nil {
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

