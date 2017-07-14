//
//  HighScoreViewController.swift
//  SimonSays
//
//  Created by Young Tech on 7/12/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //var highScoreArray: [StructOfHighScores]!
    var highScores = AppDelegate.highScoreManager.getScores()
    // UITableViewDataSource data source means that this will be the one resposible for running the data to the table view
    
    //by tomorrow, grab array off manager, return how big the array is and the number of rows and set the cells in detailed text label
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.highScores.count
        //we don't know how many rows we need
        //could return 0 or 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // we can use a struct for the section and row number 
        let cell = self.highScoreTable.dequeueReusableCell(withIdentifier: "HighScoreCell", for: indexPath)
        
        let highScoreAtIndex = self.highScores[indexPath.row]
        cell.textLabel?.text = highScoreAtIndex.name
        cell.detailTextLabel?.text = String(highScoreAtIndex.score)
        
        return cell
    }
   
    @IBAction func playAgainButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    // underscore means you don't have to explicitly name it, you don't need to name the specific type of parameter

    @IBOutlet weak var highScoreTable: UITableView!
    
    
// connect play again to the beginning of the screen

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
