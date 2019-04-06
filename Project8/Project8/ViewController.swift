//
//  ViewController.swift
//  Project8
//
//  Created by chams on 06/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    private var letterButtons: [UIButton] = []
    private var activatedButtons: [UIButton] = []
    private var solutions: [String] = []
    private var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    private var level = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        letterButtons = view.subviews.filter { $0.tag == 1001 }.map { button in
            let btn = button as! UIButton
            btn.addTarget(self, action: #selector(letterTapped),
                                for: .touchUpInside)
            return btn
        }
        loadLevel()
    }
    
    private func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits: [String] = []
        
        if let levelFilePath = Bundle.main.path(forResource: "level\(level)",
            ofType: "txt") {
            if let levelContents = try? String(contentsOfFile: levelFilePath) {
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    let solutionWord = answer.replacingOccurrences(of: "|",
                                                                   with: "")
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        
        cluesLabel.text =
        clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text =
        solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if letterBits.count == letterButtons.count {
            for i in 0..<letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
    
    private func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        letterButtons.forEach { $0.isHidden = false }
    }

    @IBAction func submitTapped(_ sender: Any) {
        if let solutionPosition = solutions.firstIndex(of: currentAnswer.text!) {
            activatedButtons.removeAll()
            
            var splitAnswers =
            answersLabel.text!.components(separatedBy: "\n")
            splitAnswers[solutionPosition] = currentAnswer.text!
            answersLabel.text = splitAnswers.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well done!",
                                           message: "Are you ready for the next level?",
                                           preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's Go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        }
    }
    
    @IBAction func clearTapped(_ sender: Any) {
        activatedButtons.forEach { $0.isHidden = false }
        activatedButtons.removeAll()
    }
    
    @IBAction func letterTapped(btn: UIButton) {
        currentAnswer.text = currentAnswer.text! + btn.titleLabel!.text!
        activatedButtons.append(btn)
        btn.isHidden = true
    }
}

