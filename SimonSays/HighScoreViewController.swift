//
//  HighScoreViewController.swift
//  SimonSays
//
//  Created by Young Tech on 7/12/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var highScores = AppDelegate.highScoreManager.getScores()
    var globalHighScores = [StructOfHighScores]()
    
    
    @IBAction func playAgainButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBOutlet weak var highScoreTable: UITableView!
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
         return self.highScores.count
        }
        else {
        return self.globalHighScores.count
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "local high scores"
        }
        else {
            return "global high scores"
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // we can use a struct for the section and row number
        let cell = self.highScoreTable.dequeueReusableCell(withIdentifier: "HighScoreCell", for: indexPath)
        if indexPath.section == 0
        {
        let highScoreAtIndex = self.highScores[indexPath.row]
        cell.textLabel?.text = highScoreAtIndex.name
        cell.detailTextLabel?.text = String(highScoreAtIndex.score)
        }
        else {
            let globalHighScoreAtIndex = self.globalHighScores[indexPath.row]
            cell.textLabel?.text = globalHighScoreAtIndex.name
            cell.detailTextLabel?.text = String(globalHighScoreAtIndex.score)
        }
        
        return cell
    }
    

    override func viewWillAppear (_ animated: Bool) {
        AppDelegate.highScoreManager.getGlobalScores { (globalHighScores) in
            self.globalHighScores = globalHighScores
            self.highScoreTable.reloadData()
    }
    }
    


//    override func viewDidLoad() {
//        super.viewDidLoad()
// 
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

}
// UITableViewDataSource data source means that this will be the one resposible for running the data to the table view
// need to be table to determine what section it wants, and use indexPathRow

// need to add another section to table view 
// tell table view I have another section
// tell table view the correct row count
// pull data from the correct array to connect scores 
//
