//
//  SnakeModel.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 21/03/2021.
//

import Foundation
import SwiftUI

struct BodyPart {
    var position: CGPoint
}

struct SnakeModel {
    var body = [BodyPart]()
    let width = GameSettings.shared.objectWidth
    let heigh = GameSettings.shared.objectHeigh
    
    var length: Int {
        return body.count
    }
    
    var headPosition: CGPoint {
        get {
            return body[0].position
        }
        set(newHeadPosition) {
            body[0].position = newHeadPosition
        }
    }
}
