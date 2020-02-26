//
//  DiceViewController.swift
//  BattleShip
//
//  Created by Ivan Ivanov on 23/02/2020.
//  Copyright © 2020 Ivan Ivanov. All rights reserved.
//

import UIKit

class DiceViewController: UIViewController {
    
 
    @IBOutlet weak var dice_left: UIImageView!
    @IBOutlet weak var dice_right: UIImageView!
    
    let dices = ["dice_1.png", "dice_2.png", "dice_3.png",
                 "dice_4.png", "dice_5.png", "dice_6.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGame()
        
    }
    
    func newGame() {
        dice_left.image = UIImage(named: dices[random()])
        dice_right.image = UIImage(named: dices[random()])
    }
    
    func random() -> Int {
        return Int.random(in: 0 ..< 6)
    }
    
    @IBAction func setNewGame(_ sender: UIButton) {
        
        newGame()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
