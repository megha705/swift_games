//
//  ViewController.swift
//  BattleShip
//
//  Created by Ivan Ivanov on 26/11/2019.
//  Copyright © 2019 Ivan Ivanov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var buttonTic: UIButton!
    @IBOutlet weak var buttonBullEye: UIButton!
    @IBOutlet weak var buttonFifteen: UIButton!
    @IBOutlet weak var buttonDice: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // переход на сегвей
    // переход по нажатию на кнопку, но сам сигвей привязан не к кнопке
    // а организована связка между вьюконтролерами и можно выбирать
    // для перехода из множества вьюконтроллеров по идентификатору сигвея
    @IBAction func sendPressed(button: UIButton){
        switch button.tag {
        case 0:
            performSegue(withIdentifier: "ticTacToeLevel", sender: nil)
        case 1:
            performSegue(withIdentifier: "bullEyeLevel", sender: nil)
        case 2:
            performSegue(withIdentifier: "fifteenLevel", sender: nil)
        default:
            return
        }
    }
    
    // возврат из вторых экранов
    // получение данных из вторых экранов
    @IBAction func uwindToMainScreen(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindSegue" else { return }
        
//        if let svc1 = segue.source as? TicViewController {
//            // self.someLabel.text = svc.someLabel.text
//            print("got data from segue TicTacToe")
//        } else if let svc2 = segue.source as? BullViewController {
//            // self.someLabel.text = svc.someLabel.text
//            print("got data from segue BullEye")
//        } else if let svc3 = segue.source as? FifteenViewController {
//            // self.someLabel.text = svc.someLabel.text
//            print("got data from segue Hanoi Tower")
//        }
    }
    
    // подготовка сегвея
    // передать данные
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ticTacToeLevel" {
//            guard let dvc = segue.destination as? TicViewController else { return }
//            dvc.login = "Tic Tac Toe"
//        } else if segue.identifier == "bullEyeLevel" {
//            guard let dvc = segue.destination as? BullViewController else { return }
//            // dvc.login = "Bull's Eye"
//        } else if segue.identifier == "fifteenLevel" {
//            guard let dvc = segue.destination as? FifteenViewController else { return }
//        }
    }
    
    
    
    
}

