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
    var titleHeader: SKSpriteNode!
    var goldHeader: SKSpriteNode!
    var goldValue: SKLabelNode!
    var confirmButton: UIButton!
    var photonCannonHeader: SKSpriteNode!
    var photonCannonSprite: SKSpriteNode!
    var photonCannonLevelHeader: SKSpriteNode!
    var photonCannonLevelValue: SKLabelNode!
    var upgradePhotonCannonButton: UIButton!
    var photonCannonPriceHeader: SKSpriteNode!
    var photonCannonPriceValue: SKLabelNode!
    var piercingBeamHeader: SKSpriteNode!
    var piercingBeamSprite: SKSpriteNode!
    var piercingBeamLevelHeader: SKSpriteNode!
    var piercingBeamLevelValue: SKLabelNode!
    var upgradePiercingBeamButton: UIButton!
    var piercingBeamPriceHeader: SKSpriteNode!
    var piercingBeamPriceValue: SKLabelNode!
    var clusterShotHeader: SKSpriteNode!
    var clusterShotSprite: SKSpriteNode!
    var clusterShotLevelHeader: SKSpriteNode!
    var clusterShotLevelValue: SKLabelNode!
    var upgradeClusterShotButton: UIButton!
    var clusterShotPriceHeader: SKSpriteNode!
    var clusterShotPriceValue: SKLabelNode!
    
    // Initialization Methods
    override func didMoveToView(view: SKView) {
        self.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.0))
        
        initializeParallaxBackground()
        initializeUIElements()
        updateUIStates()
    }
    
    private func initializeParallaxBackground() {
        self.addChild(parallaxBackground)
    }
    
    private func initializeUIElements() {
        initializeTitleBarElements()
        initializePhotonCannonElements()
        initializePiercingBeamElements()
        initializeClusterShotElements()
    }
    
    private func initializeTitleBarElements() {
        background = SKSpriteNode(imageNamed: ImageNames.upgradesMenuBackground)
        background.anchorPoint = CGPointMake(CGFloat(0.5), CGFloat(0.0))
        
        titleHeader = SKSpriteNode(imageNamed: ImageNames.upgradesTitleHeader)
        titleHeader.position.y = self.size.height - (titleHeader.size.height / 2) - Constants.titleHeaderVerticalOffset
        
        goldHeader = SKSpriteNode(imageNamed: ImageNames.upgradesGoldHeader)
        goldHeader.position.y = self.size.height - (goldHeader.size.height / 2) - Constants.goldHeaderVerticalOffset
        goldHeader.position.x = -(Constants.goldHeaderHorizontalOffset)
        
        goldValue = SKLabelNode(fontNamed: Constants.fontName)
        goldValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        goldValue.fontSize = Constants.goldValueFontSize
        goldValue.fontColor = Constants.goldValueColor
        goldValue.position.y = self.size.height - Constants.goldValueVerticalOffset
        goldValue.position.x = -(Constants.goldValueHorizontalOffset)
        
        confirmButton = UIButton(frame: CGRectMake((self.size.width / 2) - (Constants.confirmButtonWidth / 2), self.size.height - Constants.confirmButtonVerticalOffset, Constants.confirmButtonWidth, Constants.confirmButtonHeight))
        confirmButton.setImage(UIImage(named: ImageNames.upgradesConfirmButton), forState: UIControlState.Normal)
        confirmButton.addTarget(self, action: Selector("confirmUpgrades"), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addChild(background)
        self.addChild(titleHeader)
        self.addChild(goldHeader)
        self.addChild(goldValue)
        self.view!.addSubview(confirmButton)
    }
    
    private func initializePhotonCannonElements() {
        photonCannonHeader = SKSpriteNode(imageNamed: ImageNames.upgradesPhotonCannonHeader)
        photonCannonHeader.position.y = self.size.height - (photonCannonHeader.size.height / 2) - Constants.photonCannonHeaderVerticalOffset
        photonCannonHeader.position.x = -(self.size.width / 2) + (photonCannonHeader.size.width / 2) + Constants.photonCannonHeaderHorizontalOffset
        
        photonCannonSprite = SKSpriteNode(imageNamed: ImageNames.photonCannon)
        photonCannonSprite.position.y = self.size.height - (photonCannonSprite.size.height / 2) - Constants.photonCannonSpriteVerticalOffset
        photonCannonSprite.position.x = -(self.size.width / 2) + (photonCannonSprite.size.width / 2) + Constants.photonCannonSpriteHorizontalOffset
        
        photonCannonLevelHeader = SKSpriteNode(imageNamed: ImageNames.upgradesLevelHeader)
        photonCannonLevelHeader.position.y = self.size.height - (photonCannonLevelHeader.size.height / 2) - Constants.photonCannonLevelHeaderVerticalOffset
        photonCannonLevelHeader.position.x = -(self.size.width / 2) + (photonCannonLevelHeader.size.width / 2) + Constants.photonCannonLevelHeaderHorizontalOffset
        
        photonCannonLevelValue = SKLabelNode(fontNamed: Constants.fontName)
        photonCannonLevelValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        photonCannonLevelValue.fontSize = Constants.photonCannonLevelValueFontSize
        photonCannonLevelValue.fontColor = Constants.photonCannonLevelValueFontColor
        photonCannonLevelValue.position.y = self.size.height - Constants.photonCannonLevelValueVerticalOffset
        photonCannonLevelValue.position.x = -(self.size.width / 2) + Constants.photonCannonLevelValueHorizontalOffset
        
        upgradePhotonCannonButton = UIButton(frame: CGRectMake(self.size.width - Constants.upgradePhotonCannonButtonWidth - Constants.upgradePhotonCannonButtonHorizontalOffset, Constants.upgradePhotonCannonButtonVerticalOffset, Constants.upgradePhotonCannonButtonWidth, Constants.upgradePhotonCannonButtonHeight))
        upgradePhotonCannonButton.setImage(UIImage(named: ImageNames.upgradesUpgradeButton), forState: UIControlState.Normal)
        upgradePhotonCannonButton.addTarget(self, action: Selector("upgradePhotonCannon"), forControlEvents: UIControlEvents.TouchUpInside)
        
        photonCannonPriceHeader = SKSpriteNode(imageNamed: ImageNames.upgradesPriceHeader)
        photonCannonPriceHeader.position.y = self.size.height - (photonCannonPriceHeader.size.height / 2) - Constants.photonCannonPriceHeaderVerticalOffset
        photonCannonPriceHeader.position.x = (self.size.width / 2) - (photonCannonPriceHeader.size.width / 2) - Constants.photonCannonPriceHeaderHorizontalOffset
        
        photonCannonPriceValue = SKLabelNode(fontNamed: Constants.fontName)
        photonCannonPriceValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        photonCannonPriceValue.fontSize = Constants.photonCannonPriceValueFontSize
        photonCannonPriceValue.fontColor = Constants.photonCannonPriceValueFontColor
        photonCannonPriceValue.position.y = self.size.height - Constants.photonCannonPriceValueVerticalOffset
        photonCannonPriceValue.position.x = (self.size.width / 2) - Constants.photonCannonPriceValueHorizontalOffset
        
        self.addChild(photonCannonHeader)
        self.addChild(photonCannonSprite)
        self.addChild(photonCannonLevelHeader)
        self.addChild(photonCannonLevelValue)
        self.addChild(photonCannonPriceHeader)
        self.addChild(photonCannonPriceValue)
        self.view!.addSubview(upgradePhotonCannonButton)
    }

    private func initializePiercingBeamElements() {
        piercingBeamHeader = SKSpriteNode(imageNamed: ImageNames.upgradesPiercingBeamHeader)
        piercingBeamHeader.position.y = self.size.height - (piercingBeamHeader.size.height / 2) - Constants.piercingBeamHeaderVerticalOffset
        piercingBeamHeader.position.x = -(self.size.width / 2) + (piercingBeamHeader.size.width / 2) + Constants.piercingBeamHeaderHorizontalOffset
        
        piercingBeamSprite = SKSpriteNode(imageNamed: ImageNames.piercingBeam)
        piercingBeamSprite.size.height *= 0.5
        piercingBeamSprite.position.y = self.size.height - (piercingBeamSprite.size.height / 2) - Constants.piercingBeamSpriteVerticalOffset
        piercingBeamSprite.position.x = -(self.size.width / 2) + (piercingBeamSprite.size.width / 2) + Constants.piercingBeamSpriteHorizontalOffset
        
        piercingBeamLevelHeader = SKSpriteNode(imageNamed: ImageNames.upgradesLevelHeader)
        piercingBeamLevelHeader.position.y = self.size.height - (piercingBeamLevelHeader.size.height / 2) - Constants.piercingBeamLevelHeaderVerticalOffset
        piercingBeamLevelHeader.position.x = -(self.size.width / 2) + (piercingBeamLevelHeader.size.width / 2) + Constants.piercingBeamLevelHeaderHorizontalOffset
        
        piercingBeamLevelValue = SKLabelNode(fontNamed: Constants.fontName)
        piercingBeamLevelValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        piercingBeamLevelValue.fontSize = Constants.piercingBeamLevelValueFontSize
        piercingBeamLevelValue.fontColor = Constants.piercingBeamLevelValueFontColor
        piercingBeamLevelValue.position.y = self.size.height - Constants.piercingBeamLevelValueVerticalOffset
        piercingBeamLevelValue.position.x = -(self.size.width / 2) + Constants.piercingBeamLevelValueHorizontalOffset
        
        upgradePiercingBeamButton = UIButton(frame: CGRectMake(self.size.width - Constants.upgradePiercingBeamButtonWidth - Constants.upgradePiercingBeamButtonHorizontalOffset, Constants.upgradePiercingBeamButtonVerticalOffset, Constants.upgradePiercingBeamButtonWidth, Constants.upgradePiercingBeamButtonHeight))
        upgradePiercingBeamButton.setImage(UIImage(named: ImageNames.upgradesUpgradeButton), forState: UIControlState.Normal)
        upgradePiercingBeamButton.addTarget(self, action: Selector("upgradePiercingBeam"), forControlEvents: UIControlEvents.TouchUpInside)
        
        piercingBeamPriceHeader = SKSpriteNode(imageNamed: ImageNames.upgradesPriceHeader)
        piercingBeamPriceHeader.position.y = self.size.height - (piercingBeamPriceHeader.size.height / 2) - Constants.piercingBeamPriceHeaderVerticalOffset
        piercingBeamPriceHeader.position.x = (self.size.width / 2) - (piercingBeamPriceHeader.size.width / 2) - Constants.piercingBeamPriceHeaderHorizontalOffset
        
        piercingBeamPriceValue = SKLabelNode(fontNamed: Constants.fontName)
        piercingBeamPriceValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        piercingBeamPriceValue.fontSize = Constants.piercingBeamPriceValueFontSize
        piercingBeamPriceValue.fontColor = Constants.piercingBeamPriceValueFontColor
        piercingBeamPriceValue.position.y = self.size.height - Constants.piercingBeamPriceValueVerticalOffset
        piercingBeamPriceValue.position.x = (self.size.width / 2) - Constants.piercingBeamPriceValueHorizontalOffset
        
        self.addChild(piercingBeamHeader)
        self.addChild(piercingBeamSprite)
        self.addChild(piercingBeamLevelHeader)
        self.addChild(piercingBeamLevelValue)
        self.addChild(piercingBeamPriceHeader)
        self.addChild(piercingBeamPriceValue)
        self.view!.addSubview(upgradePiercingBeamButton)
    }
    
    private func initializeClusterShotElements() {
        clusterShotHeader = SKSpriteNode(imageNamed: ImageNames.upgradesClusterShotHeader)
        clusterShotHeader.position.y = self.size.height - (clusterShotHeader.size.height / 2) - Constants.clusterShotHeaderVerticalOffset
        clusterShotHeader.position.x = -(self.size.width / 2) + (clusterShotHeader.size.width / 2) + Constants.clusterShotHeaderHorizontalOffset
        
        clusterShotSprite = SKSpriteNode(imageNamed: ImageNames.upgradesClusterShotSprite)
        clusterShotSprite.position.y = self.size.height - (clusterShotSprite.size.height / 2) - Constants.clusterShotSpriteVerticalOffset
        clusterShotSprite.position.x = -(self.size.width / 2) + (clusterShotSprite.size.width / 2) + Constants.clusterShotSpriteHorizontalOffset
        
        clusterShotLevelHeader = SKSpriteNode(imageNamed: ImageNames.upgradesLevelHeader)
        clusterShotLevelHeader.position.y = self.size.height - (clusterShotLevelHeader.size.height / 2) - Constants.clusterShotLevelHeaderVerticalOffset
        clusterShotLevelHeader.position.x = -(self.size.width / 2) + (clusterShotLevelHeader.size.width / 2) + Constants.clusterShotLevelHeaderHorizontalOffset
        
        clusterShotLevelValue = SKLabelNode(fontNamed: Constants.fontName)
        clusterShotLevelValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        clusterShotLevelValue.fontSize = Constants.clusterShotLevelValueFontSize
        clusterShotLevelValue.fontColor = Constants.clusterShotLevelValueFontColor
        clusterShotLevelValue.position.y = self.size.height - Constants.clusterShotLevelValueVerticalOffset
        clusterShotLevelValue.position.x = -(self.size.width / 2) + Constants.clusterShotLevelValueHorizontalOffset
        
        upgradeClusterShotButton = UIButton(frame: CGRectMake((self.size.width - Constants.upgradeClusterShotButtonWidth - Constants.upgradeClusterShotButtonHorizontalOffset), (self.size.height - self.size.height + Constants.upgradeClusterShotButtonVerticalOffset), Constants.upgradeClusterShotButtonWidth, Constants.upgradeClusterShotButtonHeight))
        upgradeClusterShotButton.setImage(UIImage(named: ImageNames.upgradesUpgradeButton), forState: UIControlState.Normal)
        upgradeClusterShotButton.addTarget(self, action: Selector("upgradeClusterShot"), forControlEvents: UIControlEvents.TouchUpInside)
        
        clusterShotPriceHeader = SKSpriteNode(imageNamed: ImageNames.upgradesPriceHeader)
        clusterShotPriceHeader.position.y = self.size.height - (clusterShotPriceHeader.size.height / 2) - Constants.clusterShotPriceHeaderVerticalOffset
        clusterShotPriceHeader.position.x = (self.size.width / 2) - (clusterShotPriceHeader.size.width / 2) - Constants.clusterShotPriceHeaderHorizontalOffset
        
        clusterShotPriceValue = SKLabelNode(fontNamed: Constants.fontName)
        clusterShotPriceValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        clusterShotPriceValue.fontSize = Constants.clusterShotPriceValueFontSize
        clusterShotPriceValue.fontColor = Constants.clusterShotPriceValueFontColor
        clusterShotPriceValue.position.y = self.size.height - Constants.clusterShotPriceValueVerticalOffset
        clusterShotPriceValue.position.x = (self.size.width / 2) - Constants.clusterShotPriceValueHorizontalOffset
        
        upgradeClusterShotButton = UIButton(frame: CGRectMake(self.size.width - Constants.upgradeClusterShotButtonWidth - Constants.upgradeClusterShotButtonHorizontalOffset, Constants.upgradeClusterShotButtonVerticalOffset, Constants.upgradeClusterShotButtonWidth, Constants.upgradeClusterShotButtonHeight))
        upgradeClusterShotButton.setImage(UIImage(named: ImageNames.upgradesUpgradeButton), forState: UIControlState.Normal)
        upgradeClusterShotButton.addTarget(self, action: Selector("upgradeClusterShot"), forControlEvents: UIControlEvents.TouchUpInside)
        
        clusterShotPriceHeader = SKSpriteNode(imageNamed: ImageNames.upgradesPriceHeader)
        clusterShotPriceHeader.position.y = self.size.height - (clusterShotPriceHeader.size.height / 2) - Constants.clusterShotPriceHeaderVerticalOffset
        clusterShotPriceHeader.position.x = (self.size.width / 2) - (clusterShotPriceHeader.size.width / 2) - Constants.clusterShotPriceHeaderHorizontalOffset
        
        clusterShotPriceValue = SKLabelNode(fontNamed: Constants.fontName)
        clusterShotPriceValue.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        clusterShotPriceValue.fontSize = Constants.clusterShotPriceValueFontSize
        clusterShotPriceValue.fontColor = Constants.clusterShotPriceValueFontColor
        clusterShotPriceValue.position.y = self.size.height - Constants.clusterShotPriceValueVerticalOffset
        clusterShotPriceValue.position.x = (self.size.width / 2) - Constants.clusterShotPriceValueHorizontalOffset
        
        self.addChild(clusterShotHeader)
        self.addChild(clusterShotSprite)
        self.addChild(clusterShotLevelHeader)
        self.addChild(clusterShotLevelValue)
        self.addChild(clusterShotPriceHeader)
        self.addChild(clusterShotPriceValue)
        self.view!.addSubview(upgradeClusterShotButton)
    }
    
    // MARK: Observer Methods
    func upgradePhotonCannon() {
        player.gold -= photonCannonPriceValue.text.toInt()!
        player.photonCannonLevel++
        updateUIStates()
    }
    
    func upgradePiercingBeam() {
        player.gold -= piercingBeamPriceValue.text.toInt()!
        player.piercingBeamLevel++
        updateUIStates()
    }
    
    func upgradeClusterShot() {
        player.gold -= clusterShotPriceValue.text.toInt()!
        player.clusterShotLevel++
        updateUIStates()
    }
    
    func confirmUpgrades() {
        println("Upgrades Confirmed")
    }
    
    // Update Methods
    private func updateUIStates() {
        goldValue.text = "\(player.gold)"
        
        photonCannonLevelValue.text = "\(player.photonCannonLevel)"
        piercingBeamLevelValue.text = "\(player.piercingBeamLevel)"
        clusterShotLevelValue.text = "\(player.clusterShotLevel)"
        
        photonCannonPriceValue.text = "\(calculateUpgradePrice(special: Player.SpecialAbility.PhotonCannon))"
        piercingBeamPriceValue.text = "\(calculateUpgradePrice(special: Player.SpecialAbility.PiercingBeam))"
        clusterShotPriceValue.text = "\(calculateUpgradePrice(special: Player.SpecialAbility.ClusterShot))"
        
        if player.gold < photonCannonPriceValue.text.toInt() {
            upgradePhotonCannonButton.enabled = false
            upgradePhotonCannonButton.alpha = 0.5
        }
        if player.gold < piercingBeamPriceValue.text.toInt() {
            upgradePiercingBeamButton.enabled = false
            upgradePiercingBeamButton.alpha = 0.5
        }
        if player.gold < clusterShotPriceValue.text.toInt() {
            upgradeClusterShotButton.enabled = false
            upgradeClusterShotButton.alpha = 0.5
        }
    }
    
    private func calculateUpgradePrice(#special: Player.SpecialAbility) -> Int {
        switch special {
        case .PhotonCannon:
            var price = PhotonCannon.Constants.baseUpgradeCost
            var incrementValue = Double(PhotonCannon.Constants.baseUpgradeCost) * (PhotonCannon.Constants.upgradeIncrementRatio * Double(player.photonCannonLevel - 1))
            return (price + Int(incrementValue))
        case .PiercingBeam:
            var price = PiercingBeam.Constants.baseUpgradeCost
            var incrementValue = Double(PiercingBeam.Constants.baseUpgradeCost) * (PiercingBeam.Constants.upgradeIncrementRatio * Double(player.piercingBeamLevel - 1))
            return (price + Int(incrementValue))
        case .ClusterShot:
            var price = ClusterShot.Constants.baseUpgradeCost
            var incrementValue = Double(ClusterShot.Constants.baseUpgradeCost) * (ClusterShot.Constants.upgradeIncrementRatio * Double(player.clusterShotLevel - 1))
            return (price + Int(incrementValue))
        }
    }
    
    // MARK: Enums & Constants
    struct Constants {
        static let fontName = "HelveticaNeue-Medium"
        static let titleHeaderVerticalOffset: CGFloat = 30.0
        static let goldHeaderVerticalOffset: CGFloat = 70.0
        static let goldHeaderHorizontalOffset: CGFloat = 70.0
        static let goldValueVerticalOffset: CGFloat = 84.0
        static let goldValueHorizontalOffset: CGFloat = 33.0
        static let goldValueFontSize: CGFloat = 18.0
        static let goldValueColor = UIColor(red: 255/255, green: 185/255, blue: 0, alpha: 1.0)
        
        static let photonCannonHeaderVerticalOffset: CGFloat = 114.0
        static let photonCannonHeaderHorizontalOffset: CGFloat = 50.0
        static let photonCannonSpriteVerticalOffset: CGFloat = 141.0
        static let photonCannonSpriteHorizontalOffset: CGFloat = 65.0
        static let photonCannonLevelHeaderVerticalOffset: CGFloat = 182.0
        static let photonCannonLevelHeaderHorizontalOffset: CGFloat = 46.0
        static let photonCannonLevelValueVerticalOffset: CGFloat = 193.5
        static let photonCannonLevelValueHorizontalOffset: CGFloat = 105.0
        static let photonCannonLevelValueFontSize: CGFloat = 14.0
        static let photonCannonLevelValueFontColor = UIColor(red: 0, green: 215/255, blue: 0, alpha: 1.0)
        static let upgradePhotonCannonButtonVerticalOffset: CGFloat = 120.0
        static let upgradePhotonCannonButtonHorizontalOffset: CGFloat = 40.0
        static let upgradePhotonCannonButtonWidth: CGFloat = 140.0
        static let upgradePhotonCannonButtonHeight: CGFloat = 45.0
        static let photonCannonPriceHeaderVerticalOffset: CGFloat = 168.0
        static let photonCannonPriceHeaderHorizontalOffset: CGFloat = 98.0
        static let photonCannonPriceValueFontSize: CGFloat = 14.0
        static let photonCannonPriceValueFontColor = UIColor(red: 255/255, green: 185/255, blue: 0, alpha: 1.0)
        static let photonCannonPriceValueVerticalOffset: CGFloat = 179.5
        static let photonCannonPriceValueHorizontalOffset: CGFloat = 97.0
        
        static let piercingBeamHeaderVerticalOffset: CGFloat = 215.0
        static let piercingBeamHeaderHorizontalOffset: CGFloat = 47.0
        static let piercingBeamSpriteVerticalOffset: CGFloat = 245.0
        static let piercingBeamSpriteHorizontalOffset: CGFloat = 80.0
        static let piercingBeamLevelHeaderVerticalOffset: CGFloat = 289.0
        static let piercingBeamLevelHeaderHorizontalOffset: CGFloat = 46.0
        static let piercingBeamLevelValueVerticalOffset: CGFloat = 300.5
        static let piercingBeamLevelValueHorizontalOffset: CGFloat = 105.0
        static let piercingBeamLevelValueFontSize: CGFloat = 14.0
        static let piercingBeamLevelValueFontColor = UIColor(red: 0, green: 215/255, blue: 0, alpha: 1.0)
        static let upgradePiercingBeamButtonVerticalOffset: CGFloat = 225.0
        static let upgradePiercingBeamButtonHorizontalOffset: CGFloat = 40.0
        static let upgradePiercingBeamButtonWidth: CGFloat = 140.0
        static let upgradePiercingBeamButtonHeight: CGFloat = 45.0
        static let piercingBeamPriceHeaderVerticalOffset: CGFloat = 273.0
        static let piercingBeamPriceHeaderHorizontalOffset: CGFloat = 98.0
        static let piercingBeamPriceValueFontSize: CGFloat = 14.0
        static let piercingBeamPriceValueFontColor = UIColor(red: 255/255, green: 185/255, blue: 0, alpha: 1.0)
        static let piercingBeamPriceValueVerticalOffset: CGFloat = 284.5
        static let piercingBeamPriceValueHorizontalOffset: CGFloat = 97.0
        
        static let clusterShotHeaderVerticalOffset: CGFloat = 320.0
        static let clusterShotHeaderHorizontalOffset: CGFloat = 47.0
        static let clusterShotSpriteVerticalOffset: CGFloat = 350.0
        static let clusterShotSpriteHorizontalOffset: CGFloat = 68.0
        static let clusterShotLevelHeaderVerticalOffset: CGFloat = 387.0
        static let clusterShotLevelHeaderHorizontalOffset: CGFloat = 46.0
        static let clusterShotLevelValueVerticalOffset: CGFloat = 398.5
        static let clusterShotLevelValueHorizontalOffset: CGFloat = 105.0
        static let clusterShotLevelValueFontSize: CGFloat = 14.0
        static let clusterShotLevelValueFontColor = UIColor(red: 0, green: 215/255, blue: 0, alpha: 1.0)
        static let upgradeClusterShotButtonVerticalOffset: CGFloat = 329.0
        static let upgradeClusterShotButtonHorizontalOffset: CGFloat = 40.0
        static let upgradeClusterShotButtonWidth: CGFloat = 140.0
        static let upgradeClusterShotButtonHeight: CGFloat = 45.0
        static let clusterShotPriceHeaderVerticalOffset: CGFloat = 377.0
        static let clusterShotPriceHeaderHorizontalOffset: CGFloat = 98.0
        static let clusterShotPriceValueFontSize: CGFloat = 14.0
        static let clusterShotPriceValueFontColor = UIColor(red: 255/255, green: 185/255, blue: 0, alpha: 1.0)
        static let clusterShotPriceValueVerticalOffset: CGFloat = 388.0
        static let clusterShotPriceValueHorizontalOffset: CGFloat = 97.0
        
        static let confirmButtonVerticalOffset: CGFloat = 70.0
        static let confirmButtonWidth: CGFloat = 200.0
        static let confirmButtonHeight: CGFloat = 60.0
    }
}