//
//  ManagingHighScores.swift
//  SimonSays
//
//  Created by Young Tech on 7/13/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//

import UIKit
import Alamofire

class ManagingHighScores: UIViewController {
    
    var highScores = [StructOfHighScores]()
    var globalHighScores = [StructOfHighScores]()
    
    
    func submitScore(name: String, score: Int, completion: (() -> Swift.Void)? = nil) {
        let submission = StructOfHighScores(name: name, score: score)
        self.highScores.append(submission)
        self.highScores = highScores.sorted(by: { (first, second) -> Bool in return first.score > second.score })
        self.submitScoreToGlobalScoreboard(scoreToSubmit: submission, completion: completion)
        
    }
    
    private func submitScoreToGlobalScoreboard(scoreToSubmit: StructOfHighScores, completion: (() -> Swift.Void)? = nil)
        
    {
        let parameters: Parameters = [
            "initials": scoreToSubmit.name,
            "score": scoreToSubmit.score
            ]
        
        
    Alamofire.request("https://youngtechapi.azurewebsites.net/api/Simon", method: .post, parameters:parameters, encoding: JSONEncoding.default)
            
            .validate()
            
            .responseString { (DataResponse) in
                
                switch DataResponse.result {
                    
                case .success:
                    
                    print("Post Validation Successful")
                    
                case .failure(let error):
                    
                    print(error)
                    
                }
                
                completion!()
                }
        }
    func getScores() -> [StructOfHighScores]
        {
        return self.highScores
        }
    
    
    func getGlobalScores(completion: @escaping (_ globalHighScores : [StructOfHighScores]) -> Swift.Void) {
        Alamofire.request("https://youngtechapi.azurewebsites.net/api/Simon")
            .validate()
            
            .responseJSON { (response: DataResponse<Any>) in
                
                switch response.result {
                    
                case .success:
                    
                    print("Validation Successful")
                    
                case .failure(let error):
                    
                    print(error)
                    
                }
                
                
                
                let _ = response.map { json -> [StructOfHighScores] in
                    
                    let highScoreArray = json as! [Any]
                    
                    print(highScoreArray)
                    var globalScores = [StructOfHighScores]()
                    
                    for scoreDTO in highScoreArray {
                        if let highScore = StructOfHighScores(json: scoreDTO as! [String : Any])
                            {
                            globalScores.append(highScore)
                            
                        }
                        
                    }
                    
                    
                    
                    self.globalHighScores = globalScores
                    
                    return globalScores
                    
                }
                
                
                
                completion(self.globalHighScores)
                
        }
        
    }
    
}
