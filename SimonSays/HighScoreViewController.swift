//
//  HighScoreViewController.swift
//  SimonSays
//
//  Created by Young Tech on 7/12/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // UITableViewDataSource data source means that this will be the one resposible for running the data to the table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //we don't know how many rows we need
        //could return 0 or 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // we can use a struct for the section and row number 
        let cell = self.highScoreTable.dequeueReusableCell(withIdentifier: "HighScoreCell", for: indexPath)
        //for gives enough information to give back correct cell
        
        cell.textLabel?.text = "JUAN"
        cell.detailTextLabel?.text = "42"
        
        return cell
    }
    
//    func test(_ color: Int) {
//        print("")
//    }
   
    @IBAction func playAgainButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    // underscore means you don't have to explicitly name it, you don't need to name the specific type of parameter

    @IBOutlet weak var highScoreTable: UITableView!
    
    
// connect play again to the beginning of the screen

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
