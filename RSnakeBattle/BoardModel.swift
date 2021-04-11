//
//  BoardModel.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 30/03/2021.
//

import Foundation
import SwiftUI


class BoardModel {
    
    let width = SystemSettings.shared.maxScreenX - GameSettings.shared.xAdjustment
    let height = SystemSettings.shared.maxScreenY - GameSettings.shared.yAdjustment
    
    func isCollision(point: CGPoint) -> Bool {
        
        if point.x < SystemSettings.shared.minScreenX + GameSettings.shared.xAdjustment || point.x > width {
            return true
            
        }
        else if point.y < SystemSettings.shared.minScreenY + (GameSettings.shared.yAdjustment - GameSettings.shared.xAdjustment) || point.y > height + GameSettings.shared.xAdjustment {
            return true
        }
        
        return false
    }
    
}
