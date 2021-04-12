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
    
    @State var multiple: Int = 10
    
    func update() {
        score += 10 * multiple
    }
    
    func multiple(times: Int) {
        multiple = times
        
    }
    
    func reset() {
        score = 0
    }
}
