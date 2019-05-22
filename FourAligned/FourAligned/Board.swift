//
//  Board.swift
//  FourAligned
//
//  Created by chams on 16/05/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import Foundation

enum ChipColor: Int {
    case red
    case black
}

struct Board {
    static var height = 6
    static var width = 7
    static var size: Int {
        return Board.height * Board.width
    }
    
    typealias Index = Int
    
    public var chips: [ChipColor?]!
    
    init() {
        chips = Array(repeating: nil, count: Board.size)
    }
    
    func chip(atColumn column: Int, row: Int) -> ChipColor? {
        let index = rowIndex(forColumn: column, andRow: row)
        return chips[index]
    }
    
    mutating func set(chip: ChipColor, atColumn column: Int, andRow row: Int) {
        let index = rowIndex(forColumn: column, andRow: row)
        if chips[index] == nil {
            chips[index] = chip
        }
    }
    
    private func columnIndex(fromExternalColumn column: Int) -> Index {
         return column * Board.height
    }
    
    private func rowIndex(forColumn column: Int, andRow row: Int) -> Index {
        return columnIndex(fromExternalColumn: column) + row
    }
    
    func nextAvailableRow(fromColumn column: Int) -> Int? {
        let startIndex = columnIndex(fromExternalColumn: column)
        let endIndex = startIndex + Board.height
        let col = chips[startIndex..<endIndex]
        for (index, row) in col.enumerated() {
            if row == nil {
                return index
            }
        }
        return nil
    }
    
    func canMove(inColumn column: Int) -> Bool {
        return nextAvailableRow(fromColumn: column) != nil
    }
    
    func isFull() -> Bool {
        for col in 0..<Board.width {
            if canMove(inColumn: col) {
                return false
            }
        }
        return true
    }
    
    func isWin() -> Bool {
        return false
    }
    
    mutating func add(chip: ChipColor, toColumn column: Int, andRow row: Int) {
        set(chip: chip, atColumn: column, andRow: row)
    }
}
