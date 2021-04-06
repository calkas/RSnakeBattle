//
//  GameSettings.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 28/03/2021.
//

import SwiftUI

enum SnakeMove{
    case up
    case down
    case left
    case right
}

class GameSettings {
    let xAdjustment: CGFloat = 20
    let yAdjustment: CGFloat = 60
    
    let snakeStartingPoint = CGPoint(x: 200, y: 200)
    
    static let shared = GameSettings()
    
    private init() {
        
    }
    
}
