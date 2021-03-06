//
//  ViewController.swift
//  Project34bis
//
//  Created by chams on 10/05/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet var columnButtons: [UIButton]!
    public var placedChips: [[UIView]] = []
    public var board: Board!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<Board.width {
            placedChips.append([UIView]())
        }
        
        resetBoard()
    }
    
    func resetBoard() {
        board = Board()
        updateUI()
        
        for i in 0..<placedChips.count {
            for chip in placedChips[i] {
                chip.removeFromSuperview()
            }
            placedChips[i].removeAll(keepingCapacity: true)
        }
    }
    
    func addChip(inColumn column: Int, row: Int, color: UIColor) {
        let button = columnButtons[column]
        let size = min(button.frame.width, button.frame.height / 6)
        
        let rect = CGRect(x: 0, y: 0, width: size, height: size)
        
        if placedChips[column].count < row + 1 {
            let newChip = UIView()
            newChip.frame = rect
            newChip.isUserInteractionEnabled = false
            newChip.backgroundColor = color
            newChip.layer.cornerRadius = size / 2
            newChip.center = positionForChip(inColumn: column, row: row)
            newChip.transform = CGAffineTransform(translationX: 0, y: -800)
            view.addSubview(newChip)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                newChip.transform = CGAffineTransform.identity
            })
            
            placedChips[column].append(newChip)
        }
    }
    
    func positionForChip(inColumn column: Int, row: Int) -> CGPoint {
        let button = columnButtons[column]
        let size = min(button.frame.width, button.frame.height / 6)
        
        let xOffset = button.frame.midX
        var yOffset = button.frame.maxY - size / 2
        yOffset -= size * CGFloat(row)
        
        return CGPoint(x: xOffset, y: yOffset)
        
    }
    
    func updateUI() {
        title = "\(board.currentPlayer.name)'s Turn"
    }
    
    func continueGame() {
        var gameOverTitle: String? = nil
        
        let hasWon = board.isWin(for: board.currentPlayer)
        
        if hasWon {
            gameOverTitle = "\(board.currentPlayer.name) Wins"
        } else if board.isFull() {
            gameOverTitle = "Draw!"
        }
        
        if gameOverTitle != nil {
            let alert = UIAlertController(title: gameOverTitle,
                                          message: nil,
                                          preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Play Again", style: .default) { [unowned self] (action) in
                self.resetBoard()
            }
            
            alert.addAction(alertAction)
            present(alert, animated: true)
            
            return
        }
        
        board.currentPlayer = board.currentPlayer.opponent
        updateUI()
    }
    
    @IBAction func makeMove(_ sender: UIButton) {
        let column = sender.tag
        
        if let row = board.nextEmptySlot(in: column) {
            board.add(chip: board.currentPlayer.chip, in: column)
            addChip(inColumn: column, row: row, color: board.currentPlayer.color)
            continueGame()
        }
    }
}

