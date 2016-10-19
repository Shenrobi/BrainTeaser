//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Terrell Robinson on 10/18/16.
//  Copyright © 2016 FlyGoody. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController {
    
    @IBOutlet weak var yesButton: CustomButton!
    @IBOutlet weak var noButton: CustomButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var newGameButton: CustomButton!
    @IBOutlet weak var restartButton: CustomButton!
    
    var currentCard: Card!
    var previousCard: String?
    var counter: TimeInterval!
    var timer = Timer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        currentCard = createCardFromNib()
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)

        
    }
    
    @IBAction func yesPressed(_ sender: UIButton) {
        
        if gameTypeTwoSet == true {
            
            if sender.titleLabel?.text == "YES" {
                showNextCard()
                
            } else {
                titleLabel.text = "Does this card match the previous?"
                showNextCard()
            }
            
        } else if gameTypeThreeSet == true {
            if sender.titleLabel?.text == "YES" {
                showNextCard()
            } else if (sender.titleLabel?.text == "RESTART") {
                titleLabel.text = "Answer The Questions TRUE or FALSE"
                yesButton.setTitle("START", for: UIControlState())
                gameTypeThreeSet = true
                newGameButton.isHidden = true
                
                currentCard = createCardFromNib()
                currentCard.center = AnimationEngine.screenCenterPosition
                self.view.addSubview(currentCard)
                timerLabel.text = "0:30"
            } else {
                titleLabel.text = ""
                showNextCard()
            }
        }
    }
    
    @IBAction func noPressed(_ sender: UIButton) {
        checkAnswer()
        showNextCard()
    }
    
    
//    func showNextCard () {
//        
//        if let current = currentCard {
//            let cardToRemove = current
//            currentCard = nil
//            
//            AnimationEngine.animateToPosition(view: cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim: POPAnimation!, finished: Bool) -> Void in
//                cardToRemove.removeFromSuperview()
//                } as! ((POPAnimation?, Bool) -> Void))
//        }
//        
//        if let next = createCardFromNib() {
//            next.center = AnimationEngine.offScreenRightPosition
//            self.view.addSubview(next)
//            currentCard = next
//            
//            if noButton.isHidden {
//                noButton.isHidden = false
//                yesButton.setTitle("YES", for: .normal)
//            }
//            
//            AnimationEngine.animateToPosition(view: next, position: AnimationEngine.screenCenterPosition, completion: { (
//                anim: POPAnimation!, finished: Bool) in
//
//            } as! ((POPAnimation?, Bool) -> Void))
//        }
//    }
    
    
    // Functions
    
    func showNextCard(){
        
        if let current = currentCard{
            let cardToRemove = current
            currentCard = nil
            
            AnimationEngine.animateToPosition(cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim: POPAnimation?, finished: Bool) in
                cardToRemove.removeFromSuperview()
            })
        }
        
        if let next = createCardFromNib(){
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            if noButton.isHidden{
                noButton.isHidden = false
                yesButton.setTitle("YES", for: UIControlState())
                setTimer()
            }
            
            AnimationEngine.animateToPosition(next, position: AnimationEngine.screenCenterPosition, completion: { (anim:POPAnimation?, finished: Bool) in
                
            })
        }
        
    }

    
    // Game Logic Functions
    
    func checkAnswer() {
        // Game Logic Needed
    }
    
    func gameOver() {
        // Game Logic Needed
    }
    
    
    // Nib Functions
    func createCardFromNib() -> Card! {
        return Bundle.main.loadNibNamed("Card", owner: self, options: nil)?[0] as? Card
    }
    
    
    // Timer
    
    func setTimer() {
        counter = TimeInterval(30)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameVC.onTimer), userInfo: nil, repeats: true)
    }
    
    
    func timerString(_ time: TimeInterval) -> String {
        let minutes = (Int(time) / 60) % 60
        let seconds = Int(time) % 60
        return String(format: "%d:%2d", minutes, seconds)
    }
    
    
    func onTimer() {
        if (counter > 0) {
            counter = counter - 1
            timerLabel.text = timerString(counter)
        } else {
            counter = 0
            timer.invalidate()
        }
    }
    

}
