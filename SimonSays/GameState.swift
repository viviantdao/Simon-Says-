//
//  GameState.swift
//  SimonSays
//
//  Created by Poonam Hattangady on 7/7/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//

import Foundation

struct GameState {
    var sequence:[ColorType] = []
    var currentLevel:Int = 0
    var score:Int = 0
    var status:GameStatus = .notStarted
}
