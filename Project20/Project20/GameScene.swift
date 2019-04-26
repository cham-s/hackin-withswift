//
//  GameScene.swift
//  Project20
//
//  Created by chams on 26/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var gameTimer: Timer!
    private var fireworks = [SKNode]()
    
    private let leftEdge = -22
    private let bottomEdge = -22
    private let rightEdge = 1024 + 22
    
    var score = 0 {
        didSet {
            
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self,
                                         selector: #selector(launchFireworks),
                                         userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func createFirework(xMovement: CGFloat, x: Int, y: Int) {
        let node = SKNode()
        node.position = CGPoint(x: x, y: y)
        
        let firework = SKSpriteNode(imageNamed: "rocket")
        firework.colorBlendFactor = 1
        firework.name = "firework"
        node.addChild(firework)
        
        switch Int.random(in: 0...2) {
        case 0:
            firework.color = .cyan
            
        case 1:
            firework.color = .green
            
        case 2:
            firework.color = .red
        default:
            break
        }
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: xMovement, y: 1000))
        
        let move = SKAction.follow(path.cgPath, asOffset: true,
                                   orientToPath: true, speed: 200)
        
        node.run(move)
        
        let emitter = SKEmitterNode(fileNamed: "fuse")!
        emitter.position = CGPoint(x: 0, y: -22)
        node.addChild(emitter)
        
        fireworks.append(node)
        addChild(node)
    }
    
    @objc func launchFireworks() {
        let movementAmount: CGFloat = 1800
        
        switch Int.random(in: 0...3) {
        case 0:
            // fire five, straight up
            createFirework(xMovement: 0, x: 512, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 - 200, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 - 100, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 + 100, y: bottomEdge)
            createFirework(xMovement: 0, x: 512 + 200, y: bottomEdge)
        case 1:
            // fire five, in a fan
            createFirework(xMovement: 0, x: 512, y: bottomEdge)
            createFirework(xMovement: -200, x: 512 - 200, y:
                bottomEdge)
            createFirework(xMovement: -100, x: 512 - 100, y:
                bottomEdge)
            createFirework(xMovement: 100, x: 512 + 100, y:
                bottomEdge)
            createFirework(xMovement: 200, x: 512 + 200, y:
                bottomEdge)
        case 2:
            // fire five, from the left to the right
            createFirework(xMovement: movementAmount, x: leftEdge, y:
                bottomEdge + 400)
            createFirework(xMovement: movementAmount, x: leftEdge, y:
                bottomEdge + 300)
            createFirework(xMovement: movementAmount, x: leftEdge, y:
                bottomEdge + 200)
            createFirework(xMovement: movementAmount, x: leftEdge, y:
                bottomEdge + 100)
            createFirework(xMovement: movementAmount, x: leftEdge, y:
                bottomEdge)
            
        case 3:
            // fire five, from the right to the left
            createFirework(xMovement: -movementAmount, x: rightEdge,
                           y: bottomEdge + 400)
            createFirework(xMovement: -movementAmount, x: rightEdge,
                           y: bottomEdge + 300)
            createFirework(xMovement: -movementAmount, x: rightEdge,
                           y: bottomEdge + 200)
            createFirework(xMovement: -movementAmount, x: rightEdge,
                           y: bottomEdge + 100)
            createFirework(xMovement: -movementAmount, x: rightEdge,
                           y: bottomEdge)
        default:
            break
        }
    }
    
}
