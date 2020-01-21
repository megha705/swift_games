//
//  HumanViewController.swift
//  BattleShip
//
//  Created by Ivan Ivanov on 30/11/2019.
//  Copyright © 2019 Ivan Ivanov. All rights reserved.
//

import UIKit

class HumanViewController: UIViewController {
    
    var currentMove = "X"
    var cells = Array(repeating: "-", count: 9)
    
    var counterX = 0
    var counter0 = 0
    
    @IBOutlet var ticButtons: [UIButton]!
    @IBOutlet weak var scoreX: UILabel!
    @IBOutlet weak var score0: UILabel!
    
    override func viewDidLoad() {
        scoreX.text = "0"
        score0.text = "0"
        
        for button in ticButtons {
            button.backgroundColor = .none
            button.backgroundColor = .none
        }
    }
    
    func setButton(button: UIButton, currMove: String) -> Bool {
        cells[button.tag] = currMove
        if ( cells[0] == currMove && cells[1] == currMove && cells[2] == currMove ) {
            // view.isUserInteractionEnabled = false
            setButtonAtributes(first: 0, second: 1, third: 2)
        } else if ( cells[3] == currMove && cells[4] == currMove && cells[5] == currMove ) {
            setButtonAtributes(first: 3, second: 4, third: 5)
        } else if ( cells[6] == currMove && cells[7] == currMove && cells[8] == currMove ) {
            setButtonAtributes(first: 6, second: 7, third: 8)
        } else if ( cells[0] == currMove && cells[3] == currMove && cells[6] == currMove ) {
            setButtonAtributes(first: 0, second: 3, third: 6)
        } else if ( cells[1] == currMove && cells[4] == currMove && cells[7] == currMove ) {
            setButtonAtributes(first: 1, second: 4, third: 7)
        } else if ( cells[2] == currMove && cells[5] == currMove && cells[8] == currMove ) {
            setButtonAtributes(first: 2, second: 5, third: 8)
        } else if ( cells[0] == currMove && cells[4] == currMove && cells[8] == currMove ) {
            setButtonAtributes(first: 0, second: 4, third: 8)
        } else if ( cells[2] == currMove && cells[4] == currMove && cells[6] == currMove ) {
            setButtonAtributes(first: 2, second: 4, third: 6)
        }
        
        if ticButtons[0].isEnabled == false {
            return true
        }
        return false
    }
    
    func setButtonAtributes(first: Int, second: Int, third: Int) {
        ticButtons[first].backgroundColor = .red
        ticButtons[second].backgroundColor = .red
        ticButtons[third].backgroundColor = .red
        for button in ticButtons {
            button.isEnabled = false
        }
    }
    
    @IBAction func setNewGame() {
        
        for button in ticButtons {
            button.setImage(nil, for: .normal)
            button.backgroundColor = .none
            button.isEnabled = true
            cells[button.tag] = "-"
        }
    }
    
    @IBAction func sendPressed(button: UIButton) {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    
    @IBAction func ticButtonPressed(button: UIButton) {
        
        var gameOver = false
        
        guard let _ = button.currentImage else {
            if currentMove == "X" {
                button.setImage(UIImage(named: "X")?.withRenderingMode(.alwaysOriginal), for: .normal)
               gameOver = setButton(button: button, currMove: currentMove)
                if gameOver {
                    counterX += 1
                    scoreX.text = String(counterX)
                }
                currentMove = "0"
            } else {
                button.setImage(UIImage(named: "0")?.withRenderingMode(.alwaysOriginal), for: .normal)
               gameOver = setButton(button: button, currMove: currentMove)
                if gameOver {
                    counter0 += 1
                    score0.text = String(counter0)
                }
                currentMove = "X"
            }
            
            return
        }
    }
}
