//
//  ScoreBoardModel.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 11/04/2021.
//

import Foundation
import SwiftUI


class ScoreBoardModel: ObservableObject {
    
    @Published var score: Int = 0
    
    func update() {
        score += 1
    }
    
    func reset() {
        score = 0
    }
}
