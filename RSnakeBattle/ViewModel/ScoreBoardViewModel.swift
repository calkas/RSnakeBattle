//
//  ScoreBoardViewModel.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 02/05/2021.
//

import SwiftUI

class ScoreBoardViewModel: ObservableObject {
    
    @Published private var scoreBoard = ScoreBoardModel()
    
    
    func update() {
        scoreBoard.score += 1
    }
    
    func reset() {
        scoreBoard.score = 0
    }
    
    func getScore() -> Int {
        return scoreBoard.score
    }
}

