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
    
    static let rowSpacing: CGFloat = 121.0
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
    
    private var board: Board!
    private var chipNodes: [SKShapeNode]!
    private var currentPlayer: Player!
    
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
        startGame()
    }
    
    func startGame() {
        chipNodes = [SKShapeNode]()
        currentPlayer = Player(chip: .red)
        board = Board()
    }
    
    func resetGame() {
        chipNodes.forEach { $0.removeFromParent() }
        
        startGame()
    }
    
    func continueGame() {
        if board.isFull() {
            // TODO: change to sklabel
            print("Draw!")
        } else if board.isWin() {
            print("\(currentPlayer.name) WIN!")
        } else {
            currentPlayer = currentPlayer.opponent
            return
        }
        //resetGame()
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
    
    func col(forTouches touches: Set<UITouch>) -> Int? {
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
    
    func addChip(color: UIColor, inColumn column: Int) {
        let range = rowRanges[column]
        let xPostion = (range.lowerBound + range.upperBound) / 2
        let chip = SKShapeNode(circleOfRadius: 110 / 2.0)
        chip.fillColor = color
        chip.physicsBody = SKPhysicsBody(circleOfRadius: 110 / 2.0)
        chip.position = CGPoint(x: xPostion, y: GameScene.borderSize.height)
        chipNodes.append(chip)
        addChild(chip)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let col = col(forTouches: touches) {
            guard let row =  board.nextAvailableRow(fromColumn: col) else { return }
            board.add(chip: currentPlayer.chip, toColumn: col, andRow: row)
            addChip(color: currentPlayer.chipColor, inColumn: col)
            continueGame()
        }
    }
}
