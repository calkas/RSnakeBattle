//
//  BoardModel.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 30/03/2021.
//

import Foundation
import SwiftUI

class BoardModel {
    
    let beginWidth = SystemSettings.shared.minScreenX
    let endWidth = SystemSettings.shared.maxScreenX
    
    let beginHeight = SystemSettings.shared.minScreenY + GameSettings.shared.yAdjustment + GameSettings.shared.yOffset
    let endHeight = SystemSettings.shared.maxScreenY - GameSettings.shared.yAdjustment
    
    func isCollision(point: CGPoint) -> Bool {
        
        let outOfBoardX = point.x <= beginWidth || point.x >= endWidth
        let outOfBoardY = point.y <= beginHeight || point.y >= endHeight
        
        return outOfBoardX || outOfBoardY
    }
}
