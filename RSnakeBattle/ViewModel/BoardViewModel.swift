//
//  BoardViewModel.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 02/05/2021.
//

import SwiftUI

class BoardViewModel: ObservableObject {
    @Published var boardModel = BoardModel()
    
    func isCollision(point: CGPoint) -> Bool {
        let outOfBoardX = point.x <= boardModel.beginWidth || point.x >= boardModel.endWidth
        let outOfBoardY = point.y <= boardModel.beginHeight || point.y >= boardModel.endHeight
        
        return outOfBoardX || outOfBoardY
    }
}
