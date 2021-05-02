//
//  FruitViewModel.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 02/05/2021.
//

import Foundation
import SwiftUI


class FruitViewModel: ObservableObject {
    @Published var fruitModel = FruitModel()
    
    private var allowedWorkingCoords : CGPoint
    
    init(workingCoords: CGPoint) {
        allowedWorkingCoords = workingCoords
    }
    
    func create() {
        fruitModel.coordinates.x = CGFloat.random(in: fruitModel.width..<allowedWorkingCoords.x)
        fruitModel.coordinates.y = CGFloat.random(in: fruitModel.heigh..<allowedWorkingCoords.y)
    }
    
    func wasEaten(objPoint: CGPoint, objWidth: CGFloat, objHeight: CGFloat) -> Bool {
        
        // collision x-axis?
        let collisionX = fruitModel.coordinates.x + fruitModel.width >= objPoint.x &&
            objPoint.x + objWidth >= fruitModel.coordinates.x
        
        // collision y-axis?
        let collisionY = fruitModel.coordinates.y + fruitModel.heigh >= objPoint.y &&
            objPoint.y + objHeight >= fruitModel.coordinates.y;
        
        return collisionX && collisionY
    }
}
