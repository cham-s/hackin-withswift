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
        
        for i in 0...7 {
            let band = SKSpriteNode(color: UIColor.white, size: CGSize(width: 10, height: 660))
            band.position = CGPoint(x: (i * 120) + 85, y: 660 / 2)
            band.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 10, height: 660))
            band.physicsBody?.isDynamic = false
            backgroundColor = UIColor.gray
            
            addChild(band)
        }
        configureLabels()
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    func labelFor(text: String) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = text
        return label
    }
    
    func configureLabels() {
        currentPlayerLabel = labelFor(text: "Player's Turn: ")
        currentPlayerLabel.position = CGPoint(x: 150, y: 700)
        addChild(currentPlayerLabel)
        
        scoreLabel = labelFor(text: "Score: 0")
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentLocation = touch.location(in: self)
            if currentLocation.x > 85 && currentLocation.x < ((7 * 120) + 85) &&
                currentLocation.y < 660 {
                let chip = SKShapeNode(circleOfRadius: 110 / 2.0)
                chip.fillColor = UIColor.red
                chip.physicsBody = SKPhysicsBody(circleOfRadius: 110 / 2.0)
                chip.position = currentLocation
                addChild(chip)
            }
        }
    }
}
