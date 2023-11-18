//
//  LocalState.swift
//  Bankey
//
//  Created by admin on 18/11/2023.
//

import Foundation


class LocalState {
    
    private enum Keys : String {
        case hasOnboarded
    }
    public static var hasOnBoarded: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.hasOnboarded.rawValue)
        }
    }
}
