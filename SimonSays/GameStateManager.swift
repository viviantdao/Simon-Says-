//
//  GameStateManager.swift
//  SimonSays
//
//  Created by Poonam Hattangady on 7/7/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//

import Foundation
class GameStateManager {
    var gameState: GameState = GameState()

    // Checks the player's input 
    // If wrong, level ends 
    // If right, and more plays are left, keep waiting for player input 
    // If right, and no more plays left, level has succeeded
    
    
    func checkPlayerInput(playerInput:ColorType) {
    }
    
    // Game can only move to next level if: 
    // - game hasn't begun 
    // - current level has succeeded
    // GameState is updated when level increments
    func startNextLevel() {
    }

    // A new game can be started at any time
    // Starting a game starts the first level of the game
    func startNewGame() {
    }
}
