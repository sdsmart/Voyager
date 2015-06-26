//
//  GameScene.swift
//
//  Created by Steve Smart on 6/6/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    // MARK: Properties
    var parallaxBackground: ParallaxBackground?
    var titleLabel: SKSpriteNode!
    
    private var newGameButton: UIButton!
    private var continueButton: UIButton!
    private var optionsButton: UIButton!
    
    // MARK: Initialization Methods
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.5))
        
        SaveState.loadData()
        initializeTitleLabel()
        initializeParallaxBackground()
        initializeMenuButtons()
    }
    
    private func initializeTitleLabel() {
        titleLabel = SKSpriteNode(imageNamed: ImageNames.titleLabel)
        titleLabel.position.y = Constants.titleLabelVerticalOffset
        titleLabel.zPosition = 100
        
        self.addChild(titleLabel)
        
        let fadeInAction = SKAction.fadeInWithDuration(Constants.transitionAnimationDuration)
        titleLabel.runAction(fadeInAction)
    }
    
    private func initializeParallaxBackground() {
        if parallaxBackground == nil {
            parallaxBackground = ParallaxBackground(imageNames: ImageNames.parallaxBackgrounds, containerHeight: self.size.height, scrollDown: true)
            parallaxBackground!.beginScrolling()
        }
        
        self.addChild(parallaxBackground!)
    }
    
    private func initializeMenuButtons() {
        let newGameButtonFrame = CGRectMake(((self.size.width / 2) - (Constants.newGameButtonWidth / 2)), (((self.size.height / 2) - (Constants.newGameButtonHeight / 2)) + Constants.newGameButtonVerticalOffset), Constants.newGameButtonWidth, Constants.newGameButtonHeight)
        newGameButton = UIButton(frame: newGameButtonFrame)
        newGameButton.alpha = 0.0
        newGameButton.setImage(UIImage(named: ImageNames.newGameButton), forState: UIControlState.Normal)
        newGameButton.addTarget(self, action: Selector("newGame"), forControlEvents: UIControlEvents.TouchUpInside)
        
        let continueButtonFrame = CGRectMake(((self.size.width / 2) - (Constants.continueButtonWidth / 2)), (((self.size.height / 2) - (Constants.continueButtonHeight / 2)) + Constants.continueButtonVerticalOffset), Constants.continueButtonWidth, Constants.continueButtonHeight)
        continueButton = UIButton(frame: continueButtonFrame)
        continueButton.alpha = 0.0
        continueButton.setImage(UIImage(named: ImageNames.continueButton), forState: UIControlState.Normal)
        continueButton.addTarget(self, action: Selector("continueGame"), forControlEvents: UIControlEvents.TouchUpInside)
        if SaveState.isValid() == false {
            continueButton.enabled = false
        }
        
        let optionsButtonFrame = CGRectMake(((self.size.width / 2) - (Constants.optionsButtonWidth / 2)), (((self.size.height / 2) - (Constants.optionsButtonHeight / 2)) + Constants.optionsButtonVerticalOffset), Constants.optionsButtonWidth, Constants.optionsButtonHeight)
        optionsButton = UIButton(frame: optionsButtonFrame)
        optionsButton.alpha = 0.0
        optionsButton.setImage(UIImage(named: ImageNames.optionsButton), forState: UIControlState.Normal)
        optionsButton.addTarget(self, action: Selector("showOptions"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view!.addSubview(newGameButton)
        self.view!.addSubview(continueButton)
        self.view!.addSubview(optionsButton)
        
        UIView.animateWithDuration(Constants.transitionAnimationDuration) {
            self.newGameButton.alpha = 1.0
            if self.continueButton.enabled == true {
                self.continueButton.alpha = 1.0
            } else {
                self.continueButton.alpha = 0.4
            }
            self.optionsButton.alpha = 1.0
        }
    }
    
    // MARK: Observer Methods
    func newGame() {
        titleLabel.removeFromParent()
        newGameButton.removeFromSuperview()
        continueButton.removeFromSuperview()
        optionsButton.removeFromSuperview()
        
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
    
    func continueGame() {
        titleLabel.removeFromParent()
        newGameButton.removeFromSuperview()
        continueButton.removeFromSuperview()
        optionsButton.removeFromSuperview()
        
        let levelScene = LevelScene(size: self.size)
        levelScene.scaleMode = SKSceneScaleMode.AspectFill
        
        initializeSavedState(scene: levelScene)
        
        parallaxBackground!.removeFromParent()
        levelScene.parallaxBackground = parallaxBackground!
        
        self.view!.presentScene(levelScene)
    }
    
    private func initializeSavedState(#scene: LevelScene) {
        if SaveState.isValid() {
            let player = Player(parentScene: scene)
            let levelHandler = LevelHandler(scene: scene, player: player, level: SaveState.level!)
            
            scene.player = player
            scene.levelHandler = levelHandler
        }
    }
    
    func showOptions() {
        println("Show Options!")
    }
    
    // MARK: Enums & Constants
    struct Constants {
        static let transitionAnimationDuration = 0.5
        static let titleLabelVerticalOffset: CGFloat = 140.0
        static let newGameButtonWidth: CGFloat = 200.0
        static let newGameButtonHeight: CGFloat = 30.0
        static let newGameButtonVerticalOffset: CGFloat = 0.0
        static let continueButtonWidth: CGFloat = 200.0
        static let continueButtonHeight: CGFloat = 30.0
        static let continueButtonVerticalOffset: CGFloat = 75
        static let optionsButtonWidth: CGFloat = 200.0
        static let optionsButtonHeight: CGFloat = 30.0
        static let optionsButtonVerticalOffset: CGFloat = 150.0
    }
}