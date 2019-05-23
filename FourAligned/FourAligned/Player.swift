//
//  Player.swift
//  FourAligned
//
//  Created by chams on 23/05/2019.
//  Copyright © 2019 Chams. All rights reserved.
//

import Foundation
import GameplayKit

class Player: NSObject, GKGameModelPlayer {
    static var players = [Player(chip: .red), Player(chip: .black)]
    public var name: String
    public var chip: ChipColor
    public var playerId: Int
    public var opponent: Player {
        if chip == .red {
            return Player.players[1]
        } else {
            return Player.players[0]
        }
    }
    
    init(chip: ChipColor) {
        self.chip = chip
        if chip == .red {
            name = "Red"
            playerId = chip.rawValue
        } else {
            name = "Black"
            playerId = chip.rawValue
        }
    }
}
