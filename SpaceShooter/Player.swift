//
//  Player.swift
//  SpaceShooter
//
//  Created by Steve Smart on 6/9/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    var velocity: CGFloat = 0.0
    var acceleration: CGFloat = 0.0
    
    var canShoot = false
    
    var healthPercentage: Double = 1.0
    var score = 0
    
    struct Constants {
        static let friction: CGFloat = 0.25
        static let maxSpeed: CGFloat = 7.0
        static let acceleration: CGFloat = 0.70
        
        static let distanceFromBottomOfScreen: CGFloat = 135.0
        
        static let zPosition: CGFloat = 3.0
    }
}