//
//  Config.swift
//  BiometricAuth
//
//  Created by Luigi Aiello on 18/04/18.
//  Copyright © 2018 Luigi Aiello. All rights reserved.
//

import Foundation

class Config {
    // MARK: - Constants
    private static let kBiometric = "kBiometric"
    private static let kWakeUpBiometric = "kWakeUpBiometric"
    private static let kCoverMultitasking = "kCoverMultitasking"

    class func store(biometric: Bool) -> Bool {
        let defaults = UserDefaults.standard
        defaults.setValue(biometric, forKey: kBiometric)
        
        return defaults.synchronize()
    }
    class func biometric() -> Bool? {
        guard let biometric = UserDefaults.standard.value(forKey: kBiometric) as? Bool else {
            return nil
        }
        
        return biometric
    }
    
    class func store(wakeUpBiometric: Bool) -> Bool {
        let defaults = UserDefaults.standard
        defaults.setValue(wakeUpBiometric, forKey: kWakeUpBiometric)
        
        return defaults.synchronize()
    }
    class func wakeUpBiometric() -> Bool? {
        guard let wakeUpBiometric = UserDefaults.standard.value(forKey: kWakeUpBiometric) as? Bool else {
            return nil
        }
        
        return wakeUpBiometric
    }
    
    class func store(coverMultitasking: Bool) -> Bool {
        let defaults = UserDefaults.standard
        defaults.setValue(coverMultitasking, forKey: kCoverMultitasking)
        
        return defaults.synchronize()
    }
    class func coverMultitasking() -> Bool? {
        guard let coverMultitasking = UserDefaults.standard.value(forKey: kCoverMultitasking) as? Bool else {
            return nil
        }
        
        return coverMultitasking
    }
}
