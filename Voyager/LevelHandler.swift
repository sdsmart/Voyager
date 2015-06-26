//
//  LevelScripts.swift
//  Voyager
//
//  Created by Steve Smart on 6/16/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import SpriteKit

class LevelHandler {
    
    // MARK: Properties
    private let scene: LevelScene
    private let player: Player
    private var initialScreenDarkening = SKSpriteNode()
    private var levelLabel = SKSpriteNode()
    
    var enabled = false
    var currentLevel: Int
    
    // MARK: Level Specific Variables
    private struct LevelOne {
        static var alienFighterSpawnRateTimer = NSTimer()
        
        static var alienFighterCanSpawn = true
        static var alienFighterSpawnRate = 1.0
    }
    
    // MARK: Initializers
    init(scene: LevelScene, player: Player, level: Int) {
        self.scene = scene
        self.player = player
        self.currentLevel = level
        self.initialScreenDarkening = SKSpriteNode(imageNamed: ImageNames.pauseMenuDarkening)
        self.initialScreenDarkening.zPosition = Constants.initialScreenDarkeningZPosition
        
        switch level {
        case 1:
            levelLabel = SKSpriteNode(imageNamed: ImageNames.levelOneLabel)
            levelLabel.position.y = Constants.levelLabelPosition
            levelLabel.zPosition = Constants.levelLabelZPosition
            levelLabel.alpha = 0.0
        default:
            break
        }
    }
    
    // MARK: Initialization Methods
    func initialize() {
        LevelOne.alienFighterCanSpawn = true
    }
    
    // MARK: Label Management Methods
    func showLabel() {
        scene.addChild(initialScreenDarkening)
        scene.addChild(levelLabel)
        
        let fadeInAction = SKAction.fadeInWithDuration(GameController.Constants.transitionAnimationDuration)
        levelLabel.runAction(fadeInAction)
    }
    
    func hideLabel() {
        levelLabel.removeFromParent()
        initialScreenDarkening.removeFromParent()
    }
    
    // MARK: Update Methods
    func update() {
        if enabled {
            switch currentLevel {
            case 1:
                updateLevelOne()
            default:
                break
            }
        }
    }
    
    // MARK: Level One Update Methods
    private func updateLevelOne() {
        if LevelOne.alienFighterCanSpawn {
            LevelOne.alienFighterCanSpawn = false
            
            let alienFighter = AlienFighter(player: player, parentScene: self.scene)
            alienFighter.animate(AlienFighter.AnimationType.Down)
            scene.addChild(alienFighter)
            
            LevelOne.alienFighterSpawnRateTimer = NSTimer.scheduledTimerWithTimeInterval(LevelOne.alienFighterSpawnRate, target: self,
                selector: Selector("sendNewAlienFighterLevelOne"), userInfo: nil, repeats: false)
        }
    }
    
    @objc func sendNewAlienFighterLevelOne() {
        if scene.gamePaused {
            LevelOne.alienFighterSpawnRateTimer.invalidate()
            LevelOne.alienFighterSpawnRateTimer = NSTimer.scheduledTimerWithTimeInterval(LevelOne.alienFighterSpawnRate, target: self,
                selector: Selector("sendNewAlienFighterLevelOne"), userInfo: nil, repeats: false)
        } else {
            LevelOne.alienFighterCanSpawn = true
        }
    }
    
    // MARK: Enums & Constants
    struct Constants {
        static let levelLabelPosition: CGFloat = 115.0
        static let levelLabelZPosition: CGFloat = 100.0
        static let initialScreenDarkeningZPosition: CGFloat = 99.0
    }
}
