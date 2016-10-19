//
//  Card.swift
//  BrainTeaser
//
//  Created by Terrell Robinson on 10/18/16.
//  Copyright © 2016 FlyGoody. All rights reserved.
//

import UIKit

class Card: UIView {

    let shapes = ["shape1", "shape2", "shape3"]
    let numbers = ["number1", "number2", "number3"]
    let words = ["The Earth Is Round?": "true", "There's 29 states in the United States.": "false", "Microsoft makes automatic hair brushes.": "false"]
    
    var currentShape: String!
    var currentNumber: String!
    var currentWord: String!
    var currentWordValue: String!
    
    @IBOutlet weak var shapeImage: UIImageView!
    
    @IBOutlet weak var quizText: UILabel!
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            setupView()
        }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        setupView()
        
        if gameTypeOneSet == true {
            
            selectNumbers()
            shapeImage.isHidden = false
            
        } else if gameTypeTwoSet == true {
            
            shapeImage.isHidden = false
            
            selectShape()
            
        } else if gameTypeThreeSet == true {
            
            quizText.isHidden = false
            selectWords()
        } else {
            
            print("No Game Type Was Selected!")
        }
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 1.0).cgColor
        self.setNeedsLayout()
        
    }
    
    func selectShape() {
        currentShape = shapes[Int(arc4random_uniform(3))]
        shapeImage.image = UIImage(named: currentShape)
    }
    
    func selectWords() {
        let index: Int = Int(arc4random_uniform(UInt32(words.count)))
        currentWord = Array(words.keys)[index]
        currentWordValue = Array(words.values)[index]
        
        
        quizText.text = currentWord
        
        
        print(currentWord)
        print(currentWordValue)
    }
    
    func selectNumbers() {
        
        currentNumber = numbers[Int(arc4random_uniform(3))]
        shapeImage.image = UIImage(named: currentNumber)
    }

}













