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
     var index: Int = 0
    

    // Checks the player's input 
    // If wrong, level ends 
    // If right, and more plays are left, keep waiting for player input 
    // If right, and no more plays left, level has succeeded
    
    
    func checkPlayerInput(playerInput: ColorType) {
        if playerInput == gameState.sequence[index] {
            index += 1
            gameState.status = .awaitingPlayerInput
            if index == gameState.sequence.count {
                gameState.status = .levelPassed
                gameState.score += 1
            }
        }
        else {
            gameState.status = .levelFailed
        }
    }
    
    // Game can only move to next level if: 
    // - game hasn't begun 
    // - current level has succeeded
    // GameState is updated when level increments
    func startNextLevel() {
        if gameState.status == .levelPassed || gameState.status == .notStarted {
            gameState.currentLevel += 1
        gameState.status = .awaitingPlayerInput
        let newColor: ColorType = ColorType(rawValue: Int(arc4random_uniform(4)))!
            gameState.sequence.append(newColor) }
    }

    // A new game can be started at any time
    // Starting a game starts the first level of the game
    func startNewGame() {
        gameState = GameState()
        startNextLevel()
        
    }
}
