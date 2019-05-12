//
//  Board.swift
//  Project34bis
//
//  Created by chams on 10/05/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit
import GameplayKit


enum ChipColor: Int {
    case none = 0
    case red
    case black
}

class Board: NSObject {
    static var width = 7
    static var height = 6
    
    public var slots: [ChipColor] = []
    public var currentPlayer: Player
    
    override init() {
        currentPlayer = Player.allPlayers[0]
        for _ in 0..<Board.width * Board.height {
            slots.append(.none)
        }
        
        super.init()
    }
    
    func chip(inColumn column: Int, row: Int) -> ChipColor {
        return slots[row + column * Board.height]
    }
    
    func set(chip: ChipColor, in column: Int, row: Int) {
        slots[row + column * Board.height] = chip
    }
    
    func nextEmptySlot(in column: Int) -> Int? {
        for row in 0..<Board.height {
            guard chip(inColumn: column, row: row) != .none else { return row }
        }
        return nil
    }
    
    func canMove(in column: Int) -> Bool {
        return nextEmptySlot(in: column) != nil
    }
    
    func add(chip: ChipColor, in column: Int) {
        guard let availabeRow = nextEmptySlot(in: column) else { return }
        set(chip: chip, in: column, row: availabeRow)
    }
    
    func isFull() -> Bool {
        for column in 0..<Board.width {
            guard canMove(in: column) else { return false }
        }
        return true
    }
    
    func isWin(for player: GKGameModelPlayer) -> Bool {
        let chip = (player as! Player).chip
        
        for row in 0..<Board.height {
            for col in 0..<Board.width {
                if squaresMatch(initialChip: chip, row: row, col: col, moveX: 1, moveY: 0) {
                    return true
                } else if squaresMatch(initialChip: chip, row: row, col: col, moveX: 0, moveY: 1) {
                    return true
                } else if squaresMatch(initialChip: chip, row: row, col: col, moveX: 1, moveY: 1) {
                    return true
                } else if squaresMatch(initialChip: chip, row: row, col: col, moveX: 1, moveY: -1) {
                    return true
                }
            }
        }
        
        return false
    }
    
    func squaresMatch(initialChip: ChipColor,
                      row: Int,
                      col: Int,
                      moveX: Int,
                      moveY: Int) -> Bool {
        if row + (moveY * 3) < 0 { return false }
        if row + (moveY * 3) >= Board.height { return false }
        if col + (moveX * 3) < 0 { return false }
        if col + (moveX * 3) >= Board.width { return false }
        
        if chip(inColumn: col, row: row) != initialChip { return false }
        if chip(inColumn: col + (moveX * 2), row: row + (moveY * 2)) != initialChip { return false }
        if chip(inColumn: col + (moveX * 3), row: row + (moveY * 3)) != initialChip { return false }
        
        return true
        
    }
}
