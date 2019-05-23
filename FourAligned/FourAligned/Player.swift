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
    public var chipColor: UIColor
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
        playerId = chip.rawValue
        
        if chip == .red {
            name = "Red"
            chipColor = .red
        } else {
            name = "Black"
            chipColor = .black
        }
        super.init()
    }
}
