//
//  ChooseSpecialScene.swift
//  Voyager
//
//  Created by Steve Smart on 6/20/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class UpgradeScene: SKScene {
    
    // MARK: Properties
    var parallaxBackground: ParallaxBackground!
    var player: Player!
    var background: SKSpriteNode!
    var upgradesHeader: SKSpriteNode!
    var goldHeader: SKSpriteNode!
    var goldValue: SKLabelNode!
    var confirmButton: UIButton!
    
    var photonCannonHeader: SKSpriteNode!
    var photonCannonSprite: SKSpriteNode!
    var photonCannonLevelHeader: SKSpriteNode!
    var photonCannonLevelValue: SKLabelNode!
    
    var piercingBeamHeader: SKSpriteNode!
    var piercingBeamSprite: SKSpriteNode!
    var piercingBeamLevelHeader: SKSpriteNode!
    var piercingBeamLevelValue: SKLabelNode!
    
    var clusterShotHeader: SKSpriteNode!
    var clusterShotSprite: SKSpriteNode!
    var clusterShotLevelHeader: SKSpriteNode!
    var clusterShotLevelValue: SKLabelNode!
    
    // Initialization Methods
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.0))
        
        initializeParallaxBackground()
        initializeUIElements()
        initializePlayer()
    }
    
    private func initializeParallaxBackground() {
        self.addChild(parallaxBackground)
    }
    
    private func initializeUIElements() {
        background = SKSpriteNode(imageNamed: ImageNames.upgradesMenuBackground)
        background.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.0))
        
        upgradesHeader = SKSpriteNode(imageNamed: ImageNames.upgradesTitleHeader)
        upgradesHeader.position.y = background.size.height - (upgradesHeader.size.height / 2) - Constants.upgradesHeaderVerticalOffset
        upgradesHeader.position.x = -(self.size.width / 2) + (upgradesHeader.size.width / 2) + Constants.upgradesHeaderHorizontalOffset
        
        goldHeader = SKSpriteNode(imageNamed: ImageNames.upgradesGoldHeader)
        goldHeader.position.y = background.size.height - (goldHeader.size.height / 2) - Constants.goldHeaderVerticalOffset
        goldHeader.position.x = (self.size.width / 2) - (goldHeader.size.width / 2) - Constants.goldHeaderHorizontalOffset
        
        goldValue = SKLabelNode(fontNamed: Constants.fontName)
        goldValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        goldValue.fontSize = Constants.goldValueFontSize
        goldValue.fontColor = Constants.goldValueColor
        goldValue.position.y = background.size.height - Constants.goldValueVerticalOffset
        goldValue.position.x = (self.size.width / 2) - Constants.goldValueHorizontalOffset
        goldValue.text = "\(player.gold)"
        
        photonCannonHeader = SKSpriteNode(imageNamed: ImageNames.upgradesPhotonCannonHeader)
        photonCannonHeader.position.y = background.size.height - (photonCannonHeader.size.height / 2) - Constants.photonCannonHeaderVerticalOffset
        photonCannonHeader.position.x = -(self.size.width / 2) + (photonCannonHeader.size.width / 2) + Constants.photonCannonHeaderHorizontalOffset
        
        photonCannonSprite = SKSpriteNode(imageNamed: ImageNames.photonCannon)
        photonCannonSprite.position.y = background.size.height - (photonCannonSprite.size.height / 2) - Constants.photonCannonSpriteVerticalOffset
        photonCannonSprite.position.x = -(self.size.width / 2) + (photonCannonSprite.size.width / 2) + Constants.photonCannonSpriteHorizontalOffset
        
        photonCannonLevelHeader = SKSpriteNode(imageNamed: ImageNames.upgradesLevelHeader)
        photonCannonLevelHeader.position.y = background.size.height - (photonCannonLevelHeader.size.height / 2) - Constants.photonCannonLevelHeaderVerticalOffset
        photonCannonLevelHeader.position.x = -(self.size.width / 2) + (photonCannonLevelHeader.size.width / 2) + Constants.photonCannonLevelHeaderHorizontalOffset
        
        photonCannonLevelValue = SKLabelNode(fontNamed: Constants.fontName)
        photonCannonLevelValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        photonCannonLevelValue.fontSize = Constants.photonCannonLevelValueFontSize
        photonCannonLevelValue.fontColor = Constants.photonCannonLevelValueFontColor
        photonCannonLevelValue.position.y = background.size.height - Constants.photonCannonLevelValueVerticalOffset
        photonCannonLevelValue.position.x = -(self.size.width / 2) + Constants.photonCannonLevelValueHorizontalOffset
        photonCannonLevelValue.text = "\(player.photonCannonLevel)"
        
        piercingBeamHeader = SKSpriteNode(imageNamed: ImageNames.upgradesPiercingBeamHeader)
        piercingBeamHeader.position.y = background.size.height - (piercingBeamHeader.size.height / 2) - Constants.piercingBeamHeaderVerticalOffset
        
        piercingBeamSprite = SKSpriteNode(imageNamed: ImageNames.piercingBeam)
        piercingBeamSprite.size.height *= 0.5
        piercingBeamSprite.position.y = background.size.height - (piercingBeamSprite.size.height / 2) - Constants.piercingBeamSpriteVerticalOffset
        
        piercingBeamLevelHeader = SKSpriteNode(imageNamed: ImageNames.upgradesLevelHeader)
        piercingBeamLevelHeader.position.y = background.size.height - (piercingBeamLevelHeader.size.height / 2) - Constants.piercingBeamLevelHeaderVerticalOffset
        piercingBeamLevelHeader.position.x = -(Constants.piercingBeamLevelHeaderHorizontalOffset)
        
        piercingBeamLevelValue = SKLabelNode(fontNamed: Constants.fontName)
        piercingBeamLevelValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        piercingBeamLevelValue.fontSize = Constants.piercingBeamLevelValueFontSize
        piercingBeamLevelValue.fontColor = Constants.piercingBeamLevelValueFontColor
        piercingBeamLevelValue.position.y = background.size.height - Constants.piercingBeamLevelValueVerticalOffset
        piercingBeamLevelValue.position.x = Constants.piercingBeamLevelValueHorizontalOffset
        piercingBeamLevelValue.text = "\(player.piercingBeamLevel)"
        
        clusterShotHeader = SKSpriteNode(imageNamed: ImageNames.upgradesClusterShotHeader)
        clusterShotHeader.position.y = background.size.height - (clusterShotHeader.size.height / 2) - Constants.clusterShotHeaderVerticalOffset
        clusterShotHeader.position.x = (self.size.width / 2) - (clusterShotHeader.size.width / 2) - Constants.clusterShotHeaderHorizontalOffset
        
        clusterShotSprite = SKSpriteNode(imageNamed: ImageNames.upgradesClusterShotSprite)
        clusterShotSprite.position.y = background.size.height - (clusterShotSprite.size.height / 2) - Constants.clusterShotSpriteVerticalOffset
        clusterShotSprite.position.x = (self.size.width / 2) - (clusterShotSprite.size.width / 2) - Constants.clusterShotSpriteHorizontalOffset
        
        clusterShotLevelHeader = SKSpriteNode(imageNamed: ImageNames.upgradesLevelHeader)
        clusterShotLevelHeader.position.y = background.size.height - (clusterShotLevelHeader.size.height / 2) - Constants.clusterShotLevelHeaderVerticalOffset
        clusterShotLevelHeader.position.x = (self.size.width / 2) - (clusterShotLevelHeader.size.width / 2) - Constants.clusterShotLevelHeaderHorizontalOffset
        
        clusterShotLevelValue = SKLabelNode(fontNamed: Constants.fontName)
        clusterShotLevelValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        clusterShotLevelValue.fontSize = Constants.clusterShotLevelValueFontSize
        clusterShotLevelValue.fontColor = Constants.clusterShotLevelValueFontColor
        clusterShotLevelValue.position.y = background.size.height  - Constants.clusterShotLevelValueVerticalOffset
        clusterShotLevelValue.position.x = (self.size.width / 2) - Constants.clusterShotLevelValueHorizontalOffset
        clusterShotLevelValue.text = "\(player.clusterShotLevel)"
        
        confirmButton = UIButton(frame: CGRectMake(((self.size.width / 2) - (Constants.confirmButtonWidth / 2)), (self.size.height - Constants.confirmButtonVerticalOffset), Constants.confirmButtonWidth, Constants.confirmButtonHeight))
        confirmButton.setImage(UIImage(named: ImageNames.upgradesConfirmButton), forState: UIControlState.Normal)
        confirmButton.addTarget(self, action: Selector("confirmUpgrades"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addChild(background)
        self.addChild(upgradesHeader)
        self.addChild(goldHeader)
        self.addChild(goldValue)
        self.addChild(photonCannonHeader)
        self.addChild(photonCannonSprite)
        self.addChild(photonCannonLevelHeader)
        self.addChild(photonCannonLevelValue)
        self.addChild(piercingBeamHeader)
        self.addChild(piercingBeamSprite)
        self.addChild(piercingBeamLevelHeader)
        self.addChild(piercingBeamLevelValue)
        self.addChild(clusterShotHeader)
        self.addChild(clusterShotSprite)
        self.addChild(clusterShotLevelHeader)
        self.addChild(clusterShotLevelValue)
        self.view!.addSubview(confirmButton)
    }
    
    private func initializePlayer() {
        player.position.y = background.size.height + (player.size.height / 2) + Constants.playerVerticalOffset
        
        self.addChild(player)
        
        let initialFadeInAction = SKAction.fadeInWithDuration(GameController.Constants.transitionAnimationDuration)
        player.runAction(initialFadeInAction)
    }
    
    // MARK: Observer Methods
    func confirmUpgrades() {
        println("Upgrades confirmed")
    }
    
    // Update Methods
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    // MARK: Enums & Constants
    struct Constants {
        static let fontName = "HelveticaNeue-Medium"
        
        static let playerVerticalOffset: CGFloat = 25.0
        
        static let upgradesHeaderVerticalOffset: CGFloat = 10.0
        static let upgradesHeaderHorizontalOffset: CGFloat = 10.0
        
        static let goldHeaderVerticalOffset: CGFloat = 13.0
        static let goldHeaderHorizontalOffset: CGFloat = 58.0
        
        static let goldValueVerticalOffset: CGFloat = 27.0
        static let goldValueHorizontalOffset: CGFloat = 56.0
        static let goldValueFontSize: CGFloat = 16.0
        static let goldValueColor = UIColor(red: 255/255, green: 185/255, blue: 0, alpha: 1.0)
        
        static let photonCannonHeaderVerticalOffset: CGFloat = 49.0
        static let photonCannonHeaderHorizontalOffset: CGFloat = 42.0
        static let photonCannonSpriteVerticalOffset: CGFloat = 74.0
        static let photonCannonSpriteHorizontalOffset: CGFloat = 50.0
        static let photonCannonLevelHeaderVerticalOffset: CGFloat = 117.0
        static let photonCannonLevelHeaderHorizontalOffset: CGFloat = 41.0
        static let photonCannonLevelValueVerticalOffset: CGFloat = 126.0
        static let photonCannonLevelValueHorizontalOffset: CGFloat = 82.0
        static let photonCannonLevelValueFontSize: CGFloat = 12.0
        static let photonCannonLevelValueFontColor = UIColor(red: 0, green: 215/255, blue: 0, alpha: 1.0)
        
        static let piercingBeamHeaderVerticalOffset: CGFloat = 49.0
        static let piercingBeamSpriteVerticalOffset: CGFloat = 74.0
        static let piercingBeamLevelHeaderVerticalOffset: CGFloat = 117.0
        static let piercingBeamLevelHeaderHorizontalOffset: CGFloat = 8.0
        static let piercingBeamLevelValueVerticalOffset: CGFloat = 126.0
        static let piercingBeamLevelValueHorizontalOffset: CGFloat = 13.0
        static let piercingBeamLevelValueFontSize: CGFloat = 12.0
        static let piercingBeamLevelValueFontColor = UIColor(red: 0, green: 215/255, blue: 0, alpha: 1.0)
        
        static let clusterShotHeaderVerticalOffset: CGFloat = 49.0
        static let clusterShotHeaderHorizontalOffset: CGFloat = 42.0
        static let clusterShotSpriteVerticalOffset: CGFloat = 75.0
        static let clusterShotSpriteHorizontalOffset: CGFloat = 56.0
        static let clusterShotLevelHeaderVerticalOffset: CGFloat = 117.0
        static let clusterShotLevelHeaderHorizontalOffset: CGFloat = 58.0
        static let clusterShotLevelValueVerticalOffset: CGFloat = 126.0
        static let clusterShotLevelValueHorizontalOffset: CGFloat = 57.0
        static let clusterShotLevelValueFontSize: CGFloat = 12.0
        static let clusterShotLevelValueFontColor = UIColor(red: 0, green: 215/255, blue: 0, alpha: 1.0)
        
        static let confirmButtonVerticalOffset: CGFloat = 40.0
        static let confirmButtonWidth: CGFloat = 135.0
        static let confirmButtonHeight: CGFloat = 25.0
    }
}