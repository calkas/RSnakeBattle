//
//  FruitModel.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 04/04/2021.
//
import SwiftUI
import Foundation


class FruitModel: ObservableObject {
    let width: CGFloat = 30
    let heigh: CGFloat = 30
    
    var allowedWorkingCoords : CGPoint
    
    @Published var coordinates = CGPoint(x:100, y:100)
    
    init(workingCoords: CGPoint) {
        allowedWorkingCoords = workingCoords
    }
    
    func create() {
        let randX = CGFloat(Int.random(in: Int(width)..<Int(allowedWorkingCoords.x)))
        let randY = CGFloat(Int.random(in: Int(heigh)..<Int(allowedWorkingCoords.y)))
        
        coordinates.x = randX
        coordinates.y = randY
    }
    
    func wasEaten(objPoint: CGPoint, objWidth: CGFloat, objHeight: CGFloat) -> Bool {
        
        // collision x-axis?
        let collisionX = coordinates.x + width >= objPoint.x &&
            objPoint.x + objWidth >= coordinates.x
        
        // collision y-axis?
        let collisionY = coordinates.y + heigh >= objPoint.y &&
            objPoint.y + objHeight >= coordinates.y;
        
        return collisionX && collisionY
    }
}
