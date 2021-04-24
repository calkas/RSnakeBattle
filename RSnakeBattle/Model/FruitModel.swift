//
//  FruitModel.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 04/04/2021.
//
import SwiftUI
import Foundation


class FruitModel: ObservableObject {

    let width: CGFloat = 20
    let heigh: CGFloat = 20
    
    private var allowedWorkingCoords : CGPoint
    
    @Published var coordinates = CGPoint(x:100, y:100)
    
    init(workingCoords: CGPoint) {
        allowedWorkingCoords = workingCoords
    }
    
    func create() {
        coordinates.x = CGFloat.random(in: width..<allowedWorkingCoords.x)
        coordinates.y = CGFloat.random(in: heigh..<allowedWorkingCoords.y)
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
