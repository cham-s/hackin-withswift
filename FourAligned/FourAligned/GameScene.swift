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
    private let rowSpacing: CGFloat = 120.0
    private let borderWidth: CGFloat = 10.0
    private let leftPadding: CGFloat = 85.0
    
    override func didMove(to view: SKView) {
        
        let borderSize = CGSize(width: 10, height: 660)
        
        for i in 0...Board.width {
            let border = SKSpriteNode(color: UIColor.white, size: borderSize)
            border.position = CGPoint(x: (CGFloat(i) * rowSpacing) + leftPadding,
                                      y: borderSize.height / 2)
            border.physicsBody = SKPhysicsBody(rectangleOf: borderSize)
            border.physicsBody?.isDynamic = false
            backgroundColor = UIColor.gray
            addChild(border)
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
    
    func row(forTouches touches: Set<UITouch>) -> Int? {
        if let touch = touches.first {
            let currentLocation = touch.location(in: self)
            for i in 0...Board.width {
                let start = (CGFloat(i) * rowSpacing) + leftPadding + (borderWidth / 2)
                let end = start + rowSpacing
                let range = start...end
                if range ~= currentLocation.x && i < Board.width {
                    return i
                }
            }
        }
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let row = row(forTouches: touches) {
            print("row: \(row)")
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let currentLocation = touch.location(in: self)
//            if currentLocation.x > 85 && currentLocation.x < ((7 * 120) + 85) &&
//                currentLocation.y < 660 {
//                let chip = SKShapeNode(circleOfRadius: 110 / 2.0)
//                chip.fillColor = UIColor.red
//                chip.physicsBody = SKPhysicsBody(circleOfRadius: 110 / 2.0)
//                chip.position = currentLocation
//
//                addChild(chip)
//            }
//        }
//    }
}
