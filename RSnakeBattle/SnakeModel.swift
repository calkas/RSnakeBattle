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


class SnakeModel : ObservableObject {
    
    @Published var body = [BodyPart]()
    @Published var isCollisionDetected = false
    let width: CGFloat = 20
    let heigh: CGFloat = 20
    let snakeStep: CGFloat = 20
    
    var length : Int {
        return body.count
    }
    
    var headPosition: CGPoint {
        return body[0].position
    }
    
    init(startSnakePosition: CGPoint) {
        createSnake(position: startSnakePosition)
    }
    
    private func createSnake(position: CGPoint) {
        
        var snakeBodyPos = position
        
        body.append(BodyPart(position: snakeBodyPos))
        snakeBodyPos.y += heigh
        body.append(BodyPart(position: snakeBodyPos))
        snakeBodyPos.y += heigh
        body.append(BodyPart(position: snakeBodyPos))
    }
    
    func addBodyElement() {
        body.append(BodyPart(position: headPosition))
    }
    
    func move(move: SnakeMove) {
        
        var prevPos = headPosition
        
        switch move {
        case .up:
            body[0].position.y -= snakeStep
            break
        case .down:
            body[0].position.y += snakeStep
            break
        case .left:
            body[0].position.x -= snakeStep
            break
        case .right:
            body[0].position.x += snakeStep
            break
        }
        
        for part in 1..<length {
            let current = body[part].position
            body[part].position = prevPos
            prevPos = current
        }
        
        isCollisionDetected = isCollision()
    }
    
    private func isCollision() -> Bool {
        for part in 1..<length {
            if headPosition == body[part].position {
                return true
            }
        }
        return false
    }
    
    func reset(startSnakePosition: CGPoint) {
        body.removeAll()
        createSnake(position: startSnakePosition)
    }
    
}
