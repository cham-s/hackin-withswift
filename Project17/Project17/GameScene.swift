//
//  GameScene.swift
//  Project17
//
//  Created by chams on 21/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var gameScore: SKLabelNode!
    private var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    private var livesImages: [SKSpriteNode] = []
    private var lives = 3
    private var activeSliceBG: SKShapeNode!
    private var activeSliceFG: SKShapeNode!
    
    func createSlices() {
        activeSliceBG = SKShapeNode()
        activeSliceBG.zPosition = 2
        
        activeSliceFG = SKShapeNode()
        activeSliceFG.zPosition = 2
        
        activeSliceBG.strokeColor = UIColor(red: 1, green: 0.9, blue: 0, alpha: 1)
        activeSliceBG.lineWidth = 9
        
        activeSliceFG.strokeColor = UIColor.white
        activeSliceFG.lineWidth = 5
        
        addChild(activeSliceBG)
        addChild(activeSliceFG)
        
        
    }

    override func didMove(to view: SKView) {
        
        
        let background = SKSpriteNode(imageNamed: "sliceBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -6)
        physicsWorld.speed = 0.85
        
        createScore()
        createLives()
        createSlices()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func createScore() {
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.text = "Score: 0"
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        gameScore.position = CGPoint(x: 8, y: 8)
    }
    
    func createLives() {
        (0..<3).forEach { i in
            let spriteNode = SKSpriteNode(imageNamed: "sliceLife")
            spriteNode.position = CGPoint(x: CGFloat(834 + (i * 70)),
                                          y: 720)
            addChild(spriteNode)
            livesImages.append(spriteNode)
        }
    }
}
