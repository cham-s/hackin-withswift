//
//  GameScene.swift
//  Project26
//
//  Created by chams on 30/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func loadLevel() {
        if let levelPath = Bundle.main.path(forResource: "level1",
                                            ofType: "txt") {
            if let levelString = try? String(contentsOfFile: levelPath) {
                let lines = levelString.components(separatedBy: "\n")
                
                for (row, line) in lines.reversed().enumerated() {
                    for (column, letter) in line.enumerated() {
                        let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                        if letter == "x" {
                            // load wall
                        } else if letter == "v" {
                            // load vortex
                        } else if letter == "s" {
                            // load star
                        } else if letter == "f" {
                            // load finish
                        }
                    }
                }
            }
        }
    }
}
