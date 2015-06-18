//
//  SavedState.swift
//  Voyager
//
//  Created by Steve Smart on 6/17/15.
//  Copyright (c) 2015 Steve Smart. All rights reserved.
//

import Foundation

class SaveState {
    
    // MARK: Properties
    static private(set) var level: Int?
    
    // MARK: Utility Methods
    class func saveData(#level: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(level, forKey: Constants.levelKey)
    }
    
    class func loadData() {
        let defaults = NSUserDefaults.standardUserDefaults()
        level = defaults.integerForKey(Constants.levelKey)
    }
    
    class func eraseData() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey(Constants.levelKey)
    }
    
    class func isValid() -> Bool {
        if level! > 0 {
            return true
        } else {
            return false
        }
    }
    
    // MARK: Enums & Constants
    struct Constants {
        static let levelKey = "level"
    }
}
