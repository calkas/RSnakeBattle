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
    case noob = 0.3
    case normal = 0.2
    case pro = 0.1
    case hardcore = 0.05
}

class GameSettings {
    let xAdjustment: CGFloat = 20
    let yAdjustment: CGFloat = 20
    let yOffset: CGFloat = 30
    
    let snakeStartingPoint = CGPoint(x: SystemSettings.shared.maxScreenX / 2, y: SystemSettings.shared.maxScreenY / 2)
    
    let fruitStartingPoint = CGPoint(x:100, y:100)
    
    let objectWidth: CGFloat = 20
    let objectHeigh: CGFloat = 20
    
    static let shared = GameSettings()
    private init() {
    }
}
