//
//  TicViewController.swift
//  BattleShip
//
//  Created by Ivan Ivanov on 26/11/2019.
//  Copyright © 2019 Ivan Ivanov. All rights reserved.
//

import UIKit

class TicViewController: UIViewController {
    
//    var login: String!
//    @IBOutlet weak var gameNameLbl: UILabel!
    @IBOutlet weak var homeButton: UIButton!
//    @IBOutlet weak var botGame: UIButton!
//    @IBOutlet weak var humanGame: UIButton!
    
    @IBAction func sendPressed(button: UIButton) {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    
    @IBAction func uwindToTicScreen(segue: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        // guard let login = login else { return }
    }
    
    @IBAction func showHumanScreen(button: UIButton) {
        let message = "Comming soon!"
        
        let alert = UIAlertController(title: title,
                                      message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}
