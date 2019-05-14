//
//  GameScene.swift
//  FourAligned
//
//  Created by chams on 14/05/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var currentPlayerLabel: SKLabelNode!
    private var scoreLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        
    }
    
    func labelFor(text: String) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = text
        return label
    }
    
    func configureLabels() {
        currentPlayerLabel = labelFor(text: "Player's Turn: ")
        currentPlayerLabel.position = CGPoint(x: 10, y: 760)
        addChild(currentPlayerLabel)
        
        scoreLabel = labelFor(text: "Score: 0")
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
    }
}
