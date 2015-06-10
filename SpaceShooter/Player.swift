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
    static let initialPositionY: CGFloat = -150
    static let friction: CGFloat = 0.15
    static let maxSpeed: CGFloat = 7
    static let acceleration: CGFloat = 0.85
    
    var velocity: CGFloat = 0
    var acceleration: CGFloat = 0
}