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
        
        for i in 0..<placedChips.count {
            for chip in placedChips[i] {
                chip.removeFromSuperview()
            }
            placedChips[i].removeAll(keepingCapacity: true)
        }
    }
    
    @IBAction func makeMove(_ sender: UIButton) {
    }
}

