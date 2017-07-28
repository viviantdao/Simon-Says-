
//  GameScreenViewController.swift
//  SimonSays
//
//  Created by Poonam Hattangady on 7/7/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//

import UIKit

class GameScreenViewController: UIViewController {

    let animationDuration: Double = 0.25
    let animationBuffer: Double = 0.5
   
    @IBOutlet weak var RedButton: UIButton!
    
    @IBOutlet weak var GreenButton: UIButton!
    
    @IBOutlet weak var BlueButton: UIButton!
   
    @IBOutlet weak var YellowButton: UIButton!
   
    
    @IBOutlet weak var StartGame: UIButton!
    
    @IBOutlet weak var ScoreLabel: UILabel!
    //add score label
   
    
    var game = GameStateManager()
    

    
    @IBAction func startGameButton(_ sender: UIButton!) {
        ScoreLabel.text = "0"
        game.startNewGame()
        playSequence()
        StartGame.isEnabled = false
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender {
        case RedButton:
            animate(button: RedButton)
        case GreenButton:
            animate(button: GreenButton)
        case BlueButton:
            animate(button: BlueButton)
        case YellowButton:
            animate(button: YellowButton)
        default:
            break
        }
    
    
        if game.gameState.status != .notStarted {
            
            checkPlayerInput(button: sender)
        }
        
        
        if game.gameState.status == .levelPassed {
            game.startNextLevel()
            playSequence()
            ScoreLabel.text = String(game.gameState.score)
        }
         if game.gameState.status == .levelFailed {
            self.performSegue(withIdentifier: "GameOver", sender: self)
        }
        
    }
    func animate(button: UIButton) {
        UIView.animate(withDuration: animationDuration, animations: { //time duration to animate
            button.backgroundColor = button.backgroundColor?.withAlphaComponent(0.05)
        }, completion: { (completed: Bool) in
            button.backgroundColor = button.backgroundColor?.withAlphaComponent(1)
        })
    }
    
    func checkPlayerInput(button: UIButton) {
        var passButton: ColorType = ColorType.red //default
        switch button {
        case RedButton :
            passButton = ColorType.red
        case BlueButton :
            passButton = ColorType.blue
        case GreenButton :
            passButton = ColorType.green
        case YellowButton :
            passButton = ColorType.yellow
        default:
            break
        }
        game.checkPlayerInput(playerInput: passButton)
    }
        
        
    func playSequence() {
        var count: Int = 0
        self.RedButton.isEnabled = false
        self.GreenButton.isEnabled = false
        self.BlueButton.isEnabled = false
        self.YellowButton.isEnabled = false
      
        
        let _:Timer = Timer.scheduledTimer(withTimeInterval: animationDuration + animationBuffer, repeats: true) { (timer) in
            if count == self.game.gameState.sequence.count {
                timer.invalidate()
     
                self.RedButton.isEnabled = true
                self.YellowButton.isEnabled = true
                self.BlueButton.isEnabled = true
                self.GreenButton.isEnabled = true
            }
            else {
            switch self.game.gameState.sequence[count] {
            case ColorType.red:
                self.animate(button: self.RedButton)
            case ColorType.green:
                self.animate(button: self.GreenButton)
            case ColorType.blue:
                self.animate(button: self.BlueButton)
            case ColorType.yellow:
                self.animate(button: self.YellowButton)
            default:
                break
        }
           count += 1
        }
//    }
//    
    //=======second way==========\\
//    
//    RedButton.isEnabled = false
//    GreenButton.isEnabled = false
//    BlueButton.isEnabled = false
//    YellowButton.isEnabled = false
//            
//    var delay: Double =  animationBuffer
//    for color in game.gameState.sequence {
//    var buttonToAnimate: UIButton
//        switch color {
//        case ColorType.red:
//            self.animate(button: self.RedButton)
//    case ColorType.green:
//    self.animate(button: self.GreenButton)
//    case ColorType.blue:
//    self.animate(button: self.BlueButton)
//    case ColorType.yellow:
//    self.animate(button: self.YellowButton)
//    default:
//            break
//    
//    }
//    self.perform(#selector(animate(button:)), with: buttonToAnimate, afterDelay: delay)
//        delay += self.animationBuffer + self.animationDuration
//    }
//    //Enable buttons
//        RedButton.isEnabled = true
//        YellowButton.isEnabled = true
//        BlueButton.isEnabled = true
//        GreenButton.isEnabled = true
//    
//    }
//}

    
    //
    
    }
}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.StartGame.isEnabled = true //isHidden = false
        self.ScoreLabel.text = "0"
        self.game.prepareGame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        game.startNewGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameOverVC: GameOverViewController = segue.destination as? GameOverViewController {
        
        gameOverVC.score = game.gameState.score
        }
    }


}
