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
        
        let borderSize = CGSize(width: 10, height: 660)
        //let bandSize = CGSize(width: 110, height: 660)
        
        for i in 0...Board.width {
            let border = SKSpriteNode(color: UIColor.white, size: borderSize)
            border.position = CGPoint(x: (i * 120) + 85, y: 660 / 2)
            border.physicsBody = SKPhysicsBody(rectangleOf: borderSize)
            border.physicsBody?.isDynamic = false
            backgroundColor = UIColor.gray
            addChild(border)
            
//            guard i < Board.width else { continue }
//            let band = SKSpriteNode(color: UIColor.blue, size: bandSize)
//            band.position = CGPoint(x: border.position.x +
//                ((border.size.width / 2) + (band.size.width / 2)) , y: 660 / 2)
//            band.physicsBody = SKPhysicsBody(rectangleOf: bandSize)
//            band.physicsBody?.isDynamic = false
//            addChild(band)
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
            for i in 0...Board.width {
                let rowRange = ((i * 120) + 85)..<((i + 1) * 120)
                if rowRange ~= Int(currentLocation.x) {
                    print("touched row \(i)")
                }
            }
//            if currentLocation.x > 85 && currentLocation.x < ((7 * 120) + 85) &&
//                currentLocation.y < 660 {
//                let chip = SKShapeNode(circleOfRadius: 110 / 2.0)
//                chip.fillColor = UIColor.red
//                chip.physicsBody = SKPhysicsBody(circleOfRadius: 110 / 2.0)
//                chip.position = currentLocation
//
//                addChild(chip)
//            }
        }
    }
}
