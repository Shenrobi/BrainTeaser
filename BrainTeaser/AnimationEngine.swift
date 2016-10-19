//
//  AnimationEngine.swift
//  BrainTeaser
//
//  Created by Terrell Robinson on 10/18/16.
//  Copyright © 2016 FlyGoody. All rights reserved.
//

import UIKit
import pop

class AnimationEngine {
    
    static var offScreenRightPosition: CGPoint {
        return CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.midY)
    }
    
    static var offScreenLeftPosition: CGPoint {
        return CGPoint(x: -UIScreen.main.bounds.width, y: UIScreen.main.bounds.midY)
    }
    
    static var screenCenterPosition: CGPoint {
        return CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    }
    
    let ANIM_DELAY: Int = 1
    
    var originalConstants = [CGFloat]()
    var constraints: [NSLayoutConstraint]!
    
    init(constraints: [NSLayoutConstraint]) {
        
        for con in constraints {
            originalConstants.append(con.constant) // Storing the original positioning to animate back to their position
            con.constant = AnimationEngine.offScreenRightPosition.x // Immediately moves off the screen
        }
        
        self.constraints = constraints
    }
    
    func animateOnScreen(_ delay: Int) {
        
        let time = DispatchTime.now() + Double(Int64(Double(delay) * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: time) {
        
        // Animation
            var index = 0
            repeat {
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnim?.toValue = self.originalConstants[index]
                moveAnim?.springBounciness = 12
                moveAnim?.springSpeed = 12
                
                if (index > 0) {
                    moveAnim?.dynamicsFriction += 10 + CGFloat(index)
                }
                
                let con = self.constraints[index]
                con.pop_add(moveAnim, forKey: "moveOnScreen")
                
                index += 1
                
                
            } while (index < self.constraints.count)
        }
    }
    
 
    class func animateToPosition(_ view: UIView, position: CGPoint, completion: @escaping ((POPAnimation?, Bool) -> Void)) {
        let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        moveAnim?.toValue = NSValue(cgPoint: position)
        moveAnim?.springBounciness = 8
        moveAnim?.springSpeed = 8
        moveAnim?.completionBlock = completion
        view.pop_add(moveAnim, forKey: "moveToPosition")
    }
    
}
