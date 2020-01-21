//
//  BotViewController.swift
//  BattleShip
//
//  Created by Ivan Ivanov on 30/11/2019.
//  Copyright © 2019 Ivan Ivanov. All rights reserved.
//

import UIKit

class BotViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func sendPressed(button: UIButton) {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    
}
