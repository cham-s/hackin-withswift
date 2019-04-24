//
//  GameScene.swift
//  Project17
//
//  Created by chams on 21/04/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

enum ForceBomb {
    case never
    case always
    case random
}

enum SequenceType: CaseIterable {
    case oneNoBomb, one, twoWithOneBomb, two, three, four,
    chain, fastChain
}

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
    private var activeSlicePoints: [CGPoint] = []
    private var isSwooshSoundActive = false
    private var bombSoundEffect: AVAudioPlayer!
    private var activeEnemies: [SKSpriteNode] = []
    
    private var popupTime = 0.9
    private var sequence: [SequenceType]!
    private var sequencePosition = 0
    private var chainDelay = 3.0
    private var nextSequenceQueued = true
    
    
    func tossEnemies() {
        popupTime *= 0.991
        chainDelay *= 0.99
        physicsWorld.speed *= 1.02
        
        let sequenceType = sequence[sequencePosition]
        
        switch sequenceType {
        case .oneNoBomb:
            createEnemy(forceBomb: .never)
        case .one:
            createEnemy()
        case .twoWithOneBomb:
            createEnemy(forceBomb: .never)
            createEnemy(forceBomb: .always)
        case .two:
            createEnemy()
            createEnemy()
        case .three:
            createEnemy()
            createEnemy()
            createEnemy()
        case .four:
            createEnemy()
            createEnemy()
            createEnemy()
            createEnemy()
            
        case .chain:
            createEnemy()
            DispatchQueue.main.asyncAfter(deadline: .now() +
                (chainDelay / 5.0)) { [unowned self] in self.createEnemy() }
            DispatchQueue.main.asyncAfter(deadline: .now() +
                (chainDelay / 5.0 * 2)) { [unowned self] in
                    self.createEnemy() }
            DispatchQueue.main.asyncAfter(deadline: .now() +
                (chainDelay / 5.0 * 3)) { [unowned self] in
                    self.createEnemy() }
            DispatchQueue.main.asyncAfter(deadline: .now() +
                (chainDelay / 5.0 * 4)) { [unowned self] in
                    self.createEnemy() }
            
        case .fastChain:
            createEnemy()
            DispatchQueue.main.asyncAfter(deadline: .now() +
                (chainDelay / 10.0)) { [unowned self] in self.createEnemy() }
            DispatchQueue.main.asyncAfter(deadline: .now() +
                (chainDelay / 10.0 * 2)) { [unowned self] in
                    self.createEnemy() }
            DispatchQueue.main.asyncAfter(deadline: .now() +
                (chainDelay / 10.0 * 3)) { [unowned self] in
                    self.createEnemy() }
            DispatchQueue.main.asyncAfter(deadline: .now() +
                (chainDelay / 10.0 * 4)) { [unowned self] in
                    self.createEnemy() }
        }
        sequencePosition += 1
        nextSequenceQueued = false
    }
    
    func createEnemy(forceBomb: ForceBomb = .random) {
        var enemy: SKSpriteNode
        
        var enemyType = Int.random(in: 0...6)
        
        if forceBomb == .never {
            enemyType = 1
        } else if forceBomb == .always {
            enemyType = 0
        }
        
        if enemyType == 0 {
            enemy = SKSpriteNode()
            enemy.zPosition = 1
            enemy.name = "bombContainer"
            
            let bombImage = SKSpriteNode(imageNamed: "sliceBomb")
            bombImage.name = "bomb"
            enemy.addChild(bombImage)
            
            if bombSoundEffect != nil {
                bombSoundEffect.stop()
                bombSoundEffect = nil
            }
            
            let path = Bundle.main.path(forResource: "sliceBombFuse.caf", ofType: nil)!
            let url = URL(fileURLWithPath: path)
            let sound = try! AVAudioPlayer(contentsOf: url)
            bombSoundEffect = sound
            sound.play()
            
            let emitter = SKEmitterNode(fileNamed: "sliceFuse")!
            emitter.position = CGPoint(x: 76, y: 64)
            enemy.addChild(emitter)
            
        } else {
            enemy = SKSpriteNode(imageNamed: "penguin")
            run(SKAction.playSoundFileNamed("launch.caf",
                                            waitForCompletion: false))
            enemy.name = "enemy"
        }
        
        
        let randomPosition = CGPoint(x: Int.random(in: 64...960), y: -128)
        enemy.position = randomPosition
        
        let randomAngularVelocity = CGFloat.random(in: -6...6) / 2.0
        var randomXVelocity = 0
        
        if randomPosition.x < 256 {
            randomXVelocity = Int.random(in: 0...15)
        } else if randomPosition.x < 512 {
            randomXVelocity = Int.random(in: 3...5)
        } else if randomPosition.x < 768 {
            randomXVelocity = -Int.random(in: 3...5)
        } else {
            randomXVelocity = -Int.random(in: 8...15)
        }
        
        let randomYVelocity = Int.random(in: 24...32)
        
        
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: 64)
        enemy.physicsBody?.velocity = CGVector(dx: randomXVelocity * 40,
                                               dy: randomYVelocity * 40)
        enemy.physicsBody?.angularVelocity = randomAngularVelocity
        enemy.physicsBody?.collisionBitMask = 0
        
        addChild(enemy)
        activeEnemies.append(enemy)
    }
    
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
    
    func playSwooshSound() {
        isSwooshSoundActive = true
        
        let randomNumber = Int.random(in: 1...3)
        let soundName = "swoosh\(randomNumber).caf"
        
        let swooshSound = SKAction.playSoundFileNamed(soundName,
                                                      waitForCompletion: true)
        run(swooshSound) { [unowned self] in
            self.isSwooshSoundActive = false
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if activeEnemies.count > 0 {
            for node in activeEnemies {
                if node.position.y < -140 {
                    node.removeFromParent()
                    if let index = activeEnemies.firstIndex(of: node) {
                        activeEnemies.remove(at: index)
                    }
                }
            }
        } else {
            if !nextSequenceQueued {
                DispatchQueue.main.asyncAfter(deadline: .now() + popupTime) { [unowned self] in
                    self.tossEnemies()
                }
                nextSequenceQueued = true
            }
        }
        
        let bombCount = activeEnemies.filter { $0.name == "bombContainer" }.count
        if bombCount == 0 {
            if bombSoundEffect != nil {
                bombSoundEffect.stop()
                bombSoundEffect = nil
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        activeSlicePoints.append(location)
        redrawActiveSlice()
        if !isSwooshSoundActive {
            playSwooshSound()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        activeSliceBG.run(SKAction.fadeOut(withDuration: 0.25))
        activeSliceFG.run(SKAction.fadeOut(withDuration: 0.25))
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
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
        
        sequence =
            [.oneNoBomb, .oneNoBomb, .twoWithOneBomb, .twoWithOneBomb, .three,
             .one, .chain]
        for _ in 0 ... 1000 {
            let nextSequence = SequenceType.allCases.randomElement()!
            sequence.append(nextSequence)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned
            self] in
            self.tossEnemies()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        activeSlicePoints.removeAll(keepingCapacity: true)
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            activeSlicePoints.append(location)
            
            redrawActiveSlice()
            
            activeSliceBG.removeAllActions()
            activeSliceFG.removeAllActions()
            
            activeSliceBG.alpha = 1
            activeSliceFG.alpha = 1
        }
    }
    
    func redrawActiveSlice() {
        if activeSlicePoints.count < 2 {
            activeSliceBG.path = nil
            activeSliceFG.path = nil
            return
        }
        
        while activeSlicePoints.count > 12 {
            activeSlicePoints.remove(at: 0)
        }
        
        let path = UIBezierPath()
        path.move(to: activeSlicePoints[0])
        
        for i in 1..<activeSlicePoints.count {
            path.addLine(to: activeSlicePoints[i])
        }
        
        activeSliceFG.path = path.cgPath
        activeSliceBG.path = path.cgPath
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
