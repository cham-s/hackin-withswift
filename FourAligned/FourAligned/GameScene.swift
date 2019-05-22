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
    static let rowSpacing: CGFloat = 120.0
    static let leftPadding: CGFloat = 85.0
    static let borderSize = CGSize(width: 10, height: 660)
    private lazy var rowRanges: [ClosedRange<CGFloat>] = {
        var ranges: [ClosedRange<CGFloat>] = []
        for i in 0...Board.width {
            let start = (CGFloat(i) * GameScene.rowSpacing) + GameScene.leftPadding + (GameScene.borderSize.width / 2)
            let end = start + GameScene.rowSpacing
            let range = start...end
            ranges.append(range)
        }
        return ranges
    }()
    
    override func didMove(to view: SKView) {
        
        for i in 0...Board.width {
            let border = SKSpriteNode(color: UIColor.white, size: GameScene.borderSize)
            border.position = CGPoint(x: (CGFloat(i) * GameScene.rowSpacing) + GameScene.leftPadding,
                                      y: GameScene.borderSize.height / 2)
            border.physicsBody = SKPhysicsBody(rectangleOf: GameScene.borderSize)
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
            guard currentLocation.y < GameScene.borderSize.height else { return nil }
            for (row, range) in rowRanges.enumerated() {
                if range ~= currentLocation.x && row < Board.width {
                    return row
                }
            }
        }
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let row = row(forTouches: touches) {
            // print("row: \(row)")
            let range = rowRanges[row]
            let xPostion = (range.lowerBound + range.upperBound) / 2
            let chip = SKShapeNode(circleOfRadius: 110 / 2.0)
            chip.fillColor = UIColor.red
            chip.physicsBody = SKPhysicsBody(circleOfRadius: 110 / 2.0)
            chip.position = CGPoint(x: xPostion, y: GameScene.borderSize.height)

            addChild(chip)
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
