//
//  BullViewController.swift
//  BattleShip
//
//  Created by Ivan Ivanov on 19/12/2019.
//  Copyright © 2019 Ivan Ivanov. All rights reserved.
//

import UIKit

class BullViewController: UIViewController {
    
    var currentValue = 0
    var roundValue = 1
    var scoreValue = 0
    var targetValue = 0
    

    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = String(scoreValue)
        roundLabel.text = String(roundValue)
        slider.value = Float(50)
        targetValue = Int.random(in: 1...100)
        targetLabel.text = String(targetValue)
    }
    
    @IBAction func sendPressed(button: UIButton) {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = Int(slider.value.rounded())
        print(currentValue)
    }
    
    @IBAction func showAlert(button: UIButton) {
        
        if roundValue == 99 {
            roundValue = 0
            scoreValue = 0
            startNewGameRounds()
        } else {
            let difference = abs(currentValue - targetValue)
            var points = 100 - difference
            scoreValue += points
            
            if scoreValue >= 9999 {
                roundValue = 0
                scoreValue = 0
                startNewGameScore()
            } else {
                let title: String
                if difference == 0 {
                    title = "Perfect!"
                    points += 100
                } else if difference < 5 {
                    title = "You almost had it!"
                    if difference == 1 {
                        points += 50
                    }
                } else if difference < 10 {
                    title = "Pretty good!"
                } else {
                    title = "Not even close..."
                }
                
                let message = "You scored \(points)"
                
                let alert = UIAlertController(title: title,
                                              message: message, preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK",
                                           style: .default, handler: {
                                            action in
                                            self.startNewRound() //callback
                                            // startNewRound выполниться только после выполнения
                                            // alert
                })
                
                alert.addAction(action)
                
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    func startNewGameScore() {
        
        let message = "You reached the limit of score!\nStart a new game."
        
        let alert = UIAlertController(title: title,
                                      message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .default, handler: {
                                    action in
                                    self.startNewRound() //callback
                                    // startNewRound выполниться только после выполнения
                                    // alert
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func startNewGameRounds() {
        
        let message = "You reached the limit of rounds!\nStart a new game."
        
        let alert = UIAlertController(title: title,
                                      message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .default, handler: {
                                    action in
                                    self.startNewRound() //callback
                                    // startNewRound выполниться только после выполнения
                                    // alert
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func startNewRound() {
        roundValue += 1
        slider.value = Float(50)
        targetValue = Int.random(in: 1...100)
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(scoreValue)
        roundLabel.text = String(roundValue)
    }
    
    @IBAction func startNewGame(button: UIButton) {
        slider.value = Float(50)
        targetValue = Int.random(in: 1...100)
        targetLabel.text = String(targetValue)
        scoreValue = 0
        roundValue = 1
        scoreLabel.text = String(scoreValue)
        roundLabel.text = String(roundValue)
    }

}
