//
//  SimonSaysTests.swift
//  SimonSaysTests
//
//  Created by Poonam Hattangady on 7/7/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//

import XCTest
@testable import SimonSays

class SimonSaysTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNewGameManager() {
        let gm = GameStateManager()
        XCTAssert(gm.gameState.currentLevel == 0, "Current Level should be 0")
        XCTAssert(gm.gameState.score == 0, "Score should be 0")
        XCTAssert(gm.gameState.status == .notStarted, "Status should be not started")
        XCTAssert(gm.gameState.sequence.count == 0, "Sequence should be empty")
    }
    
    // -------------------------------------------------------------------------------
    // Next Level test cases
    // -------------------------------------------------------------------------------
    
    func testStartNewGameStartsLevel() {
        let gm = GameStateManager()
        gm.startNewGame()
        
        let state = gm.gameState
        XCTAssertEqual(state.currentLevel, 1)
        XCTAssertEqual(state.score, 0)
        XCTAssertEqual(state.sequence.count, 1)
        XCTAssertEqual(state.status, .awaitingPlayerInput)
    }
    
    func testNewLevelWhenLevelNotEnded() {
        let gm = GameStateManager()
        gm.startNewGame()
        gm.startNextLevel()
        let state = gm.gameState
        
        // Game should not move ahead
        XCTAssertEqual(state.currentLevel, 1)
        XCTAssertEqual(state.score, 0)
        XCTAssertEqual(state.sequence.count, 1)
        XCTAssertEqual(state.status, .awaitingPlayerInput)
    }
    
    func testNewLevelOnLevelSuccess() {
        let gm = GameStateManager()
        gm.startNewGame()
        var state = gm.gameState
        gm.checkPlayerInput(playerInput: state.sequence[0])
        
        gm.startNextLevel()
        state = gm.gameState
        
        XCTAssertEqual(state.currentLevel, 2)
        XCTAssertEqual(state.score, 1)
        XCTAssertEqual(state.sequence.count, 2)
        XCTAssertEqual(state.status, .awaitingPlayerInput)
    }
    
    // -------------------------------------------------------------------------------
    // Player Input Success Cases
    // -------------------------------------------------------------------------------
    
    func testCheckPlayerInputSuccessSingleSequence() {
        let gm = GameStateManager()
        gm.startNewGame()
        var state = gm.gameState
        gm.checkPlayerInput(playerInput: state.sequence[0])
        state = gm.gameState
        
        XCTAssertEqual(state.status, .levelPassed)
        XCTAssertEqual(state.score, 1)
        XCTAssertEqual(state.currentLevel, 1)
        XCTAssertEqual(state.sequence.count, 1)
    }
    
    func testCheckPlayerInputSuccessMultipleSequence() {
        let gm = GameStateManager()
        gm.startNewGame()
        var state = gm.gameState
        gm.checkPlayerInput(playerInput: state.sequence[0])
        
        gm.startNextLevel()
        state = gm.gameState
        gm.checkPlayerInput(playerInput: state.sequence[0])
        gm.checkPlayerInput(playerInput: state.sequence[1])
        state = gm.gameState
        
        XCTAssertEqual(state.status, .levelPassed)
        XCTAssertEqual(state.score, 2)
        XCTAssertEqual(state.currentLevel, 2)
        XCTAssertEqual(state.sequence.count, 2)
    }
    
    // -------------------------------------------------------------------------------
    // Player Input Failed Cases
    // -------------------------------------------------------------------------------

    func testCheckPlayerInputFailedFirstInSingleSequnce() {
        let gm = GameStateManager()
        gm.startNewGame()
        
        var state = gm.gameState
        let nextSequenceToTest = (state.sequence[0].rawValue + 1) % 4
        let incorrectColor:ColorType! = ColorType(rawValue: nextSequenceToTest)
        
        gm.checkPlayerInput(playerInput: incorrectColor)
        state = gm.gameState
        
        XCTAssertEqual(state.currentLevel, 1)
        XCTAssertEqual(state.score, 0)
        XCTAssertEqual(state.sequence.count, 1)
        XCTAssertEqual(state.status, .levelFailed)
    }

    func testCheckPlayerInputFailedFirstInMultipleSequnce() {
        let gm = GameStateManager()
        
        // Level 1
        gm.startNewGame()
        var state = gm.gameState
        gm.checkPlayerInput(playerInput: state.sequence[0])
        
        // Level 2
        gm.startNextLevel()
        let nextSequenceToTest = (state.sequence[0].rawValue + 1) % 4
        let incorrectColor:ColorType! = ColorType(rawValue: nextSequenceToTest)
        gm.checkPlayerInput(playerInput: incorrectColor)
        state = gm.gameState
        
        XCTAssertEqual(state.currentLevel, 2)
        XCTAssertEqual(state.score, 1)
        XCTAssertEqual(state.sequence.count, 2)
        XCTAssertEqual(state.status, .levelFailed)
    }

    func testCheckPlayerInputFailedLastInSequence() {
        let gm = GameStateManager()
        
        // Level 1
        gm.startNewGame()
        var state = gm.gameState
        gm.checkPlayerInput(playerInput: state.sequence[0])

        // Level 2
        gm.startNextLevel()
        state = gm.gameState
        gm.checkPlayerInput(playerInput: state.sequence[0])
        let nextSequenceToTest = (state.sequence[1].rawValue + 1) % 4
        let incorrectColor:ColorType! = ColorType(rawValue: nextSequenceToTest)
        gm.checkPlayerInput(playerInput: incorrectColor)
        state = gm.gameState
        
        XCTAssertEqual(state.currentLevel, 2)
        XCTAssertEqual(state.score, 1)
        XCTAssertEqual(state.sequence.count, 2)
        XCTAssertEqual(state.status, .levelFailed)
    }
    
//    func testCheckPlayerInputFailedAfterAttemptInLevelTwo() {
//        let gm = GameStateManager()
//        
//        //Level 1
//        gm.startNewGame()
//        var state = gm.gameState()
//        gm.checkPlayerInput(playerInput: <#T##ColorType#>)
//    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        // test performance 
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
