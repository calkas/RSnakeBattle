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
    
    func addLastBodyElement(_ move: SnakeMove) {
        if let currentLastBodyElement = body.last {
            var newLastBodyElement = currentLastBodyElement.position
            switch move {
                case .up: newLastBodyElement.y += heigh
                case .down: newLastBodyElement.y -= heigh
                case .right: newLastBodyElement.x += width
                case .left: newLastBodyElement.x -= width
            }
            body.append(BodyPart(position: newLastBodyElement)) 
        }
    }
    
    func move(_ move: SnakeMove) {
        
        var prevPos = headPosition
        
        switch move {
            case .up: headPosition.y -= heigh
            case .down: headPosition.y += heigh
            case .left: headPosition.x -= width
            case .right: headPosition.x += width
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
