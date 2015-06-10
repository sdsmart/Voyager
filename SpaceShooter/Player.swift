//
//  Player.swift
//  SpaceShooter
//
//  Created by Steve Smart on 6/9/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    static let imageName = "player-ship"
    static let initialPositionY: CGFloat = -400
    static let initialVelocity: CGFloat = 3
    static let initialAcceleration: CGFloat = 1.5
    static let friction: CGFloat = 0.15
    static let maxSpeed: CGFloat = 10
    static let maxAcceleration: CGFloat = 10
    
    var velocity: CGFloat = 0
    var acceleration: CGFloat = 0
}