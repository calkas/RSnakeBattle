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

enum GameLevel: Double {
    case noob = 0.4
    case normal = 0.3
    case pro = 0.1
    case hardcore = 0.05
}

class GameSettings {
    let xAdjustment: CGFloat = 20
    let yAdjustment: CGFloat = 60
    
    let snakeStartingPoint = CGPoint(x: 200, y: 200)
    
    static let shared = GameSettings()
    
    private init() {
        
    }
    
}
