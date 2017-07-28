//
//  StructOfHighScores.swift
//  SimonSays
//
//  Created by Young Tech on 7/13/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//

import Foundation
struct StructOfHighScores { //HighScore 

    var name: String = ""
    var score: Int = 0
}

extension StructOfHighScores {
        
        init?(json: [String: Any]) {
            guard let name = json["initials"] as? String,
                let score = json["score"] as? Int
                else {
                    return nil
                }
            
            self.name = name;
            self.score = score;
            
        }
    }

