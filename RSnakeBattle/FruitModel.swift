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
    
    private var allowedWorkingCoords : CGPoint
    
    @Published var coordinates = CGPoint(x:100, y:100)
    
    init(workingCoords: CGPoint) {
        allowedWorkingCoords = workingCoords
    }
    
    func create() {
        coordinates.x = CGFloat.random(in: width..<allowedWorkingCoords.x)
        coordinates.y = CGFloat.random(in: heigh..<allowedWorkingCoords.y)
    }

    func create_t(objPoint: CGPoint, objWidth: CGFloat, objHeight: CGFloat, objLength: Int) {

        let rightXBoundary = objPoint.x 
        let leftXBoundary = (objPoint.x + objWidth) * CGFloat(objLength)

        let rightYBoundary = objPoint.y
        let leftYBoundary = (objPoint.y + objHeight) * CGFloat(objLength)

        let randX_1 = CGFloat.random(in: width..<(rightXBoundary - width))
        let randX_2 = CGFloat.random(in: leftXBoundary..<(allowedWorkingCoords.x - leftXBoundary))
        let randY_1 = CGFloat.random(in: heigh..<(rightYBoundary - heigh))
        let randY_2 = CGFloat.random(in: leftYBoundary..<(allowedWorkingCoords.y - leftYBoundary))

        coordinates.x = Int.random(in: 0 ... 1) == 0 ? randX_1 : randX_2
        coordinates.y = Int.random(in: 0 ... 1) == 0 ? randY_1 : randY_2
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
