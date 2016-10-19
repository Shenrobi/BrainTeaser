//
//  GameTypeVC.swift
//  BrainTeaser
//
//  Created by Terrell Robinson on 10/19/16.
//  Copyright © 2016 FlyGoody. All rights reserved.
//

import UIKit

class GameTypeVC: UIViewController {
    
    @IBOutlet weak var gameTypeOne: NSLayoutConstraint!
    
    @IBOutlet weak var gameTypeTwo: NSLayoutConstraint!
    
    @IBOutlet weak var gameTypeThree: NSLayoutConstraint!
    
    var animationEngine: AnimationEngine!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.animationEngine = AnimationEngine(constraints: [gameTypeOne, gameTypeTwo, gameTypeThree])
    }

    
    override func viewDidAppear(_ animated: Bool) {
        self.animationEngine.animateOnScreen(0)
    }
    
    @IBAction func gameTypeOneTapped(_ sender: AnyObject) {
        
        gameTypeOneSet = true
    }
    
    @IBAction func gameTypeTwoTapped(_ sender: AnyObject) {
        
        gameTypeTwoSet = true
        
    }
    
    @IBAction func gameTypeThreeTapped(_ sender: AnyObject) {
        
        gameTypeThreeSet = true
        
    }
    

}

