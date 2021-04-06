//
//  SystemSettings.swift
//  
//
//  Created by Piotr Rybka on 14/03/2021.
//

import SwiftUI


class SystemSettings {
    let minScreenX = UIScreen.main.bounds.minX
    let maxScreenX = UIScreen.main.bounds.maxX
    let minScreenY = UIScreen.main.bounds.minY
    let maxScreenY = UIScreen.main.bounds.maxY
    
    static let shared = SystemSettings()
    
    private init() {
        
    }
}
