//
//  Board.swift
//  Project34bis
//
//  Created by chams on 10/05/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import UIKit


enum ChipColor: Int {
    case none = 0
    case red
    case black
}

class Board: NSObject {
    static var width = 7
    static var height = 6
    
    public var slots: [ChipColor] = []
    
    override init() {
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
}
