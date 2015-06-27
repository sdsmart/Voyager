//
//  GameOverScene.swift
//  Voyager
//
//  Created by Steve Smart on 6/26/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    // MARK: Properties
    var parallaxBackground: ParallaxBackground!
    var gameOverLabel: SKSpriteNode!
    var playAgainButton: UIButton!
    var mainMenuButton: UIButton!
    
    // Initialization Methods
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.5))
        
        self.addChild(parallaxBackground)
        initializeUIElements()
    }
    
    private func initializeUIElements() {
        gameOverLabel = SKSpriteNode(imageNamed: ImageNames.gameOverLabel)
        gameOverLabel.position.y = Constants.gameOverLabelVerticalOffset
        
        playAgainButton = UIButton(frame: CGRectMake(((self.size.width / 2) - (Constants.playAgainButtonWidth / 2)), ((self.size.height / 2) - (Constants.playAgainButtonHeight / 2) + Constants.playAgainButtonVerticalOffset), Constants.playAgainButtonWidth, Constants.playAgainButtonHeight))
        playAgainButton.setImage(UIImage(named: ImageNames.playAgainButton), forState: UIControlState.Normal)
        playAgainButton.addTarget(self, action: Selector("playAgain"), forControlEvents: UIControlEvents.TouchUpInside)
        
        mainMenuButton = UIButton(frame: CGRectMake(((self.size.width / 2) - (Constants.mainMenuButtonWidth / 2)), ((self.size.height / 2) - (Constants.mainMenuButtonHeight / 2) + Constants.mainMenuButtonVerticalOffset), Constants.mainMenuButtonWidth, Constants.mainMenuButtonHeight))
        mainMenuButton.setImage(UIImage(named: ImageNames.mainMenuButton), forState: UIControlState.Normal)
        mainMenuButton.addTarget(self, action: Selector("goToMainMenu"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addChild(gameOverLabel)
        self.view!.addSubview(playAgainButton)
        self.view!.addSubview(mainMenuButton)
    }
    
    // MARK: Observer Methods
    
    func playAgain() {
        playAgainButton.removeFromSuperview()
        mainMenuButton.removeFromSuperview()
        
        SaveState.eraseData()
        
        let levelScene = LevelScene(size: self.size)
        levelScene.scaleMode = SKSceneScaleMode.AspectFill
        
        parallaxBackground!.removeFromParent()
        levelScene.parallaxBackground = parallaxBackground!
        
        let player = Player(parentScene: levelScene)
        levelScene.player = player
        
        let levelHandler = LevelHandler(scene: levelScene, player: player, level: 1)
        levelScene.levelHandler = levelHandler
        
        self.view!.presentScene(levelScene)
    }
    
    func goToMainMenu() {
        playAgainButton.removeFromSuperview()
        mainMenuButton.removeFromSuperview()
        
        SaveState.eraseData()
        
        let menuScene = MenuScene(size: self.size)
        menuScene.scaleMode = SKSceneScaleMode.AspectFill
        
        parallaxBackground.removeFromParent()
        menuScene.parallaxBackground = parallaxBackground
        
        self.view!.presentScene(menuScene)
    }
    
    // MARK: Enums & Constants
    struct Constants {
        static let gameOverLabelVerticalOffset: CGFloat = 100.0
        static let playAgainButtonWidth: CGFloat = 190.0
        static let playAgainButtonHeight: CGFloat = 35.0
        static let playAgainButtonVerticalOffset: CGFloat = 20.0
        static let mainMenuButtonWidth: CGFloat = 190.0
        static let mainMenuButtonHeight: CGFloat = 35.0
        static let mainMenuButtonVerticalOffset: CGFloat = 100.0
    }
}