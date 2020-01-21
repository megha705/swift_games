//
//  TowerViewController.swift
//  BattleShip
//
//  Created by Ivan Ivanov on 23/12/2019.
//  Copyright © 2019 Ivan Ivanov. All rights reserved.
//

import UIKit

class FifteenViewController: UIViewController {
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    // var counter = 0
    var numbers: [Int] = []
    let buttonTitles = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11",
                        "12", "13", "14", "15", ""]
    
    var isGameOver = false
    var isSet = false
    
    var timer = Timer()
    var roundCounter = 1
    var secondCounter = 0
    var minuteCounter = 0
    
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isSet {
            isSet = true
            setNewGame()
        } else {
            if self.checkGameOver() {
                self.stopTimer()
                self.showAlert()
            }
        }
    }
    
    // start timer
    func startTimer() {
        timer.invalidate() // just in case this button is tapped multiple times
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    // stop timer
    func stopTimer() {
        timer.invalidate()
    }
    
    // called every time interval from the timer
    @objc func timerAction() {
        
        secondCounter += 1

        if secondCounter < 10 {
            secondLabel.text = "0\(secondCounter)"
        } else {
            if secondCounter < 60 {
            secondLabel.text = "\(secondCounter)"
            } else {
                secondCounter = 0
                minuteCounter += 1
                secondLabel.text = "0\(secondCounter)"
            }
        }
        
        if minuteCounter < 10 {
            minuteLabel.text = "0\(minuteCounter)"
        } else if minuteCounter < 59 {
            minuteLabel.text = "\(minuteCounter)"
        } else {
            stopTimer()
            showAlertTimeOut()
        }
    }
    
    
    func setNewGame() {
        
        var buttonCounter = 0
        numbers.removeAll()
        isGameOver = false
        minuteLabel.text = "00"
        secondLabel.text = "00"
        secondCounter = 0
        minuteCounter = 0
        
        repeat {
            let number = Int.random(in: 1...16)
            if !numbers.contains(number) {
                numbers.append(number)
            }
        } while numbers.count < 16
        
        for button in buttons {
            button.tag = buttonCounter
            if numbers[buttonCounter] == 16 {
                button.backgroundColor = .none
                button.setTitle("", for: .normal)
            } else {
                button.backgroundColor = .yellow
                button.setTitle(String(numbers[buttonCounter]), for: .normal)
            }
            buttonCounter += 1
        }
        
        startTimer()
    }
    
    
    func checkGameOver() -> Bool {
        var isGameOver = true
        
        for number in 0...15 {
            if numbers[number] != number + 1 {
                isGameOver = false
                break
            }
        }
        
        return isGameOver
    }
    
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Congratulations!",
                                      message: "You spent \(minuteCounter) minutes and \(secondCounter) seconds", preferredStyle: .alert)
        
//        let action = UIAlertAction(title: "OK",
//                                   style: .default, handler: {
//                                    action in
//                                    self.setNewGame()
        let action = UIAlertAction(title: "OK",
                                   style: .default)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func showAlertTimeOut() {
        
        let alert = UIAlertController(title: "The game is stopped!",
                                      message: "You have not played for 1 hour", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .default, handler: {
                                    action in self.setNewGame()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertFailed() {
        
        let alert = UIAlertController(title: "The game is stopped!",
                                      message: "You spent 99 minutes", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .default)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func resetRoundCounterAlert() {
        
        let alert = UIAlertController(title: "Congratulations! You did 99 rounds!",
                                      message: "The rounds counter will be reset!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK",
                                   style: .default)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
//    func fakeOrder() {
//        for i in 0..<buttons.count
//        {
//            buttons[i].setTitle(buttonTitles[i], for: .normal)
//            buttons[i].backgroundColor = .yellow
//            numbers[i] = i
//        }
//        buttons[15].backgroundColor = .none
//    }
    
    
    func setNewOrder(sender: UIButton) {
        
        var rightCell = 0
        var leftCell = 0
        var lowerCell = 0
        var upperCell = 0
        var counter = 0
        
        if (sender.tag - 1 >= 0) && sender.tag != 4 && sender.tag != 8 && sender.tag != 12 {
            leftCell = numbers[sender.tag - 1]
        }
        if (sender.tag + 1 <= 15) && sender.tag != 3 && sender.tag != 7 && sender.tag != 11 {
            rightCell = numbers[sender.tag + 1]
        }
        if sender.tag - 4 >= 0 {
            upperCell = numbers[sender.tag - 4]
        }
        if sender.tag + 4 <= 15 {
            lowerCell = numbers[sender.tag + 4]
        }
        
        if rightCell == 16 {
            let cellContent = numbers[sender.tag]
            numbers[sender.tag] = numbers[sender.tag + 1]
            numbers[sender.tag + 1] = cellContent
            // print("Move to the Right")
        }  else if leftCell == 16 {
            let cellContent = numbers[sender.tag]
            numbers[sender.tag] = numbers[sender.tag - 1]
            numbers[sender.tag - 1] = cellContent
            // print("Move to the Left")
        }  else if lowerCell == 16 {
            let cellContent = numbers[sender.tag]
            numbers[sender.tag] = numbers[sender.tag + 4]
            numbers[sender.tag + 4] = cellContent
            // print("Move Downwards")
        }  else if upperCell == 16 {
            let cellContent = numbers[sender.tag]
            numbers[sender.tag] = numbers[sender.tag - 4]
            numbers[sender.tag - 4] = cellContent
            // print("Move Upwards")
        }
        
        for number in numbers {
            if number != 16 {
                buttons[counter].setTitle(String(number), for: .normal)
                buttons[counter].backgroundColor = .yellow
            } else {
                buttons[counter].setTitle("", for: .normal)
                buttons[counter].backgroundColor = .none
            }
            counter += 1
        }
    }
    
    
    @IBAction func moveButton(button: UIButton) {
        
        setNewOrder(sender: button)
        
        if self.checkGameOver() {
            
            roundCounter += 1
            if roundCounter < 10 {
                roundLabel.text = "0\(roundCounter)"
            } else if roundCounter < 99 {
                roundLabel.text = "\(roundCounter)"
            } else {
                resetRoundCounterAlert()
            }
            
            self.stopTimer()
            self.showAlert()
        }
    }
    
    
    @IBAction func goBackToMainScreen(button: UIButton) {
        performSegue(withIdentifier: "unwindSegue", sender: nil)
    }
    
    
    @IBAction func newGame(button: UIButton) {
        setNewGame()
    }
    
}




//func makeMove(button: UIButton) {
//    var currentButtonNumber = button.tag - 1
//    if ( currentButtonNumber >= 0 && currentButtonNumber <= 15 ) && button.tag != 4 && button.tag != 8 && button.tag != 12 {
//        guard buttons[button.tag - 1].backgroundColor != .none else {
//            buttons[button.tag - 1].backgroundColor = .yellow
//            buttons[button.tag - 1].setTitle(button.titleLabel?.text, for: .normal)
//            buttons[button.tag].backgroundColor = .none
//            button.setTitle("", for: .normal)
//            return
//        }
//    }
//
//    currentButtonNumber = button.tag + 1
//    if ( currentButtonNumber >= 0 && currentButtonNumber <= 15 ) && button.tag != 3 && button.tag != 7 && button.tag != 11 {
//        guard buttons[button.tag + 1].backgroundColor != .none else {
//            buttons[button.tag + 1].backgroundColor = .yellow
//            buttons[button.tag + 1].setTitle(button.titleLabel?.text, for: .normal)
//            buttons[button.tag].backgroundColor = .none
//            button.setTitle("", for: .normal)
//            return
//        }
//    }
//
//    currentButtonNumber = button.tag - 4
//    if currentButtonNumber >= 0 && currentButtonNumber <= 15 {
//        guard buttons[button.tag - 4].backgroundColor != .none else {
//            buttons[button.tag - 4].backgroundColor = .yellow
//            buttons[button.tag - 4].setTitle(button.titleLabel?.text, for: .normal)
//            buttons[button.tag].backgroundColor = .none
//            button.setTitle("", for: .normal)
//            return
//        }
//    }
//
//    currentButtonNumber = button.tag + 4
//    if currentButtonNumber >= 0 && currentButtonNumber <= 15 {
//        guard buttons[button.tag + 4].backgroundColor != .none else {
//            buttons[button.tag + 4].backgroundColor = .yellow
//            buttons[button.tag + 4].setTitle(button.titleLabel?.text, for: .normal)
//            buttons[button.tag].backgroundColor = .none
//            button.setTitle("", for: .normal)
//            return
//        }
//    }
//}





////
////  TowerViewController.swift
////  BattleShip
////
////  Created by Ivan Ivanov on 23/12/2019.
////  Copyright © 2019 Ivan Ivanov. All rights reserved.
////
//
//import UIKit
//
//class FifteenViewController: UIViewController {
//
//    @IBOutlet weak var stack_1: UIStackView!
//    @IBOutlet weak var button_1: UIButton!
//    var fakeCounter = 0
//
//    var counter = 0
//    var numbers: [Int] = []
//    let rightOrderNumbers = Array (1...16)
//    let buttonTitles = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11",
//                        "12", "13", "14", "15", ""]
//    var isGameOver = false
//    var timerCounter = 0
//    var timer = Timer()
//
//    var isSet = false
//
//    @IBOutlet var buttons: [UIButton]!
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if !isSet {
//            isSet = true
//            setNewGame()
//        } else {
//            if self.checkGameOver() {
//                self.stopTimer()
//                self.showAlert()
//            }
//        }
//
//        // fakeOrder()
//    }
//
//
//    func viewLoadSetup(){
//        // setup view did load here
//    }
//
//
//    // start timer
//    func startTimer() {
//        timer.invalidate() // just in case this button is tapped multiple times
//
//        // start the timer
//        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
//    }
//
//    // stop timer
//    func stopTimer() {
//        timer.invalidate()
//    }
//
//    // called every time interval from the timer
//    @objc func timerAction() {
//        timerCounter += 1
//        // label.text = "\(counter)"
//    }
//
//
//    func setNewGame() {
//        fakeCounter = 0
//
//        counter = 0
//        numbers.removeAll()
//        isGameOver = false
//        timerCounter = 0
//
//        repeat {
//            let number = Int.random(in: 1...16)
//            if !numbers.contains(number) {
//                numbers.append(number)
//            }
//        } while numbers.count < 16
//
//
//        for button in buttons {
//            button.tag = counter
//            if numbers[counter] == 16 {
//                button.backgroundColor = .none
//                button.setTitle("", for: .normal)
//            } else {
//                button.backgroundColor = .yellow
//                button.setTitle(String(numbers[counter]), for: .normal)
//            }
//            counter += 1
//        }
//
//        startTimer()
//    }
//
//
//    func checkGameOver() -> Bool {
//        var isGameOver = false
//        var rightOrderCounter = 0
//
//        for number in 0...14 {
//            if (buttons[number].titleLabel?.text == String(number + 1)) {
//                rightOrderCounter += 1
//            } else {
//                rightOrderCounter = 0
//                break
//            }
//        }
//
//        if rightOrderCounter == 15 {
//            isGameOver = true
//        }
//
//        return isGameOver
//
//    } // checkGameOver()
//
//
//    func showAlert() {
//        var minutes = 0
//        var seconds = 0
//
//        if timerCounter < 60 {
//            seconds = timerCounter
//        } else if timerCounter == 60 {
//            minutes = 1
//            seconds = 0
//        } else {
//            seconds = timerCounter % 60
//            minutes = (timerCounter - seconds) / 60
//        }
//
//        // timerCounter
//        let alert = UIAlertController(title: "Congratulations!",
//                                      message: "You spent \(minutes) minutes and \(seconds) seconds", preferredStyle: .alert)
//
//        let action = UIAlertAction(title: "OK",
//                                   style: .default, handler: {
//                                    action in
//                                    self.setNewGame()
//        })
//
//        alert.addAction(action)
//
//        present(alert, animated: true, completion: nil)
//    }
//
//    func makeMove(button: UIButton) {
//        var currentButtonNumber = button.tag - 1
//        if ( currentButtonNumber >= 0 && currentButtonNumber <= 15 ) && button.tag != 4 && button.tag != 8 && button.tag != 12 {
//            guard buttons[button.tag - 1].backgroundColor != .none else {
//                buttons[button.tag - 1].backgroundColor = .yellow
//                buttons[button.tag - 1].setTitle(button.titleLabel?.text, for: .normal)
//                buttons[button.tag].backgroundColor = .none
//                button.setTitle("", for: .normal)
//                return
//            }
//        }
//
//        currentButtonNumber = button.tag + 1
//        if ( currentButtonNumber >= 0 && currentButtonNumber <= 15 ) && button.tag != 3 && button.tag != 7 && button.tag != 11 {
//            guard buttons[button.tag + 1].backgroundColor != .none else {
//                buttons[button.tag + 1].backgroundColor = .yellow
//                buttons[button.tag + 1].setTitle(button.titleLabel?.text, for: .normal)
//                buttons[button.tag].backgroundColor = .none
//                button.setTitle("", for: .normal)
//                return
//            }
//        }
//
//        currentButtonNumber = button.tag - 4
//        if currentButtonNumber >= 0 && currentButtonNumber <= 15 {
//            guard buttons[button.tag - 4].backgroundColor != .none else {
//                buttons[button.tag - 4].backgroundColor = .yellow
//                buttons[button.tag - 4].setTitle(button.titleLabel?.text, for: .normal)
//                buttons[button.tag].backgroundColor = .none
//                button.setTitle("", for: .normal)
//                return
//            }
//        }
//
//        currentButtonNumber = button.tag + 4
//        if currentButtonNumber >= 0 && currentButtonNumber <= 15 {
//            guard buttons[button.tag + 4].backgroundColor != .none else {
//                buttons[button.tag + 4].backgroundColor = .yellow
//                buttons[button.tag + 4].setTitle(button.titleLabel?.text, for: .normal)
//                buttons[button.tag].backgroundColor = .none
//                button.setTitle("", for: .normal)
//                return
//            }
//        }
//
//    }
//
//    func fakeOrder() {
//        for i in 0..<buttons.count
//        {
//              buttons[i].setTitle(buttonTitles[i], for: .normal)
//              buttons[i].backgroundColor = .yellow
//            numbers[i] = i
//        }
//        buttons[15].backgroundColor = .none
//    }
//
//
//    @IBAction func moveButton(button: UIButton) {
//
//        makeMove(button: button)
//
//        self.fakeOrder()
//
//        if self.checkGameOver() {
//            self.stopTimer()
//            self.showAlert()
//        }
//
//    }
//
////    override func viewWillAppear(_: Bool) {
////        super.viewWillAppear(true)
////        if self.checkGameOver() {
////            self.stopTimer()
////            self.showAlert()
////        }
////        //call your data populating/API calls from here
////
////    }
//
//    @IBAction func goBackToMainScreen(button: UIButton) {
//        performSegue(withIdentifier: "unwindSegue", sender: nil)
//    }
//
//    @IBAction func newGame(button: UIButton) {
//        setNewGame()
//    }
//
//
//
//}
//
//
////func showAlert() {
////    var minutes = 0
////    var seconds = 0
////
////    if timerCounter < 60 {
////        seconds = timerCounter
////    } else if timerCounter == 60 {
////        minutes = 1
////        seconds = 0
////    } else {
////        seconds = timerCounter % 60
////        minutes = (timerCounter - seconds) / 60
////    }
////
////    // timerCounter
////    let alert = UIAlertController(title: "Congratulations!",
////                                  message: "You spent \(minutes) minutes and \(seconds) seconds", preferredStyle: .alert)
////
////    let action = UIAlertAction(title: "OK",
////                               style: .default, handler: {
////                                action in
////                                self.setNewGame() //callback
////                                // startNewRound выполниться только после выполнения
////                                // alert
////    })
////
////    alert.addAction(action)
////
////    present(alert, animated: true, completion: nil)
////    //        let message = "Comming soon!"
////    //
////    //        let alert = UIAlertController(title: title,
////    //                                      message: message, preferredStyle: .alert)
////    //
////    //        let action = UIAlertAction(title: "OK",
////    //                                   style: .default, handler: nil)
////    //
////    //        alert.addAction(action)
////    //
////    //        present(alert, animated: true, completion: nil)
////}
