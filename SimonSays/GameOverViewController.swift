//
//  GameOverViewController.swift
//  SimonSays
//
//  Created by Young Tech on 7/12/17.
//  Copyright © 2017 Microsoft. All rights reserved.

import UIKit

class GameOverViewController: UIViewController {
    
    var score: Int = 0
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBAction func SubmitScore(_ sender: Any)
    
    {
        guard let name = self.nameTextField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else {
            return
            // after ripping out whitespaces, are you left with nothing? otherwise, return 
            // guard let statement means do this and do this, and then the result it the evaluation
        }
        
        AppDelegate.highScoreManager.submitScore(name: name, score: self.score) {
            self.performSegue(withIdentifier: "highScoreSegue", sender: self)
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scoreLabel.text = String(score)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
