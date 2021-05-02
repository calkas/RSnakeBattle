//
//  SnakeViewModel.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 02/05/2021.
//

import Foundation
import SwiftUI

class SnakeViewModel: ObservableObject {
    @Published var snakeModel = SnakeModel()
    @Published var isCollisionDetected = false
    
    init(startSnakePosition: CGPoint) {
        createSnake(position: startSnakePosition)
    }
    
    func move(_ move: SnakeMove) {
        var prevPos = snakeModel.headPosition
        
        switch move {
        case .up: snakeModel.headPosition.y -= snakeModel.heigh
        case .down: snakeModel.headPosition.y += snakeModel.heigh
        case .left: snakeModel.headPosition.x -= snakeModel.width
        case .right: snakeModel.headPosition.x += snakeModel.width
        }
        
        for part in 1..<snakeModel.length {
            let current = snakeModel.body[part].position
            snakeModel.body[part].position = prevPos
            prevPos = current
        }
        
        isCollisionDetected = isCollision()
    }
    
    func addLastBodyElement(_ move: SnakeMove) {
        if let currentLastBodyElement = snakeModel.body.last {
            var newLastBodyElement = currentLastBodyElement.position
            switch move {
            case .up: newLastBodyElement.y += snakeModel.heigh
            case .down: newLastBodyElement.y -= snakeModel.heigh
            case .right: newLastBodyElement.x += snakeModel.width
            case .left: newLastBodyElement.x -= snakeModel.width
            }
            snakeModel.body.append(BodyPart(position: newLastBodyElement))
        }
    }
    
    func reset(startSnakePosition: CGPoint) {
        snakeModel.body.removeAll()
        createSnake(position: startSnakePosition)
    }
    
    private func isCollision() -> Bool {
        for part in 1..<snakeModel.length {
            if snakeModel.headPosition == snakeModel.body[part].position {
                return true
            }
        }
        return false
    }
    
    private func createSnake(position: CGPoint) {
        var snakeBodyPos = position
        snakeModel.body.append(BodyPart(position: snakeBodyPos))
        snakeBodyPos.y += snakeModel.heigh
        snakeModel.body.append(BodyPart(position: snakeBodyPos))
        snakeBodyPos.y += snakeModel.heigh
        snakeModel.body.append(BodyPart(position: snakeBodyPos))
    }
    
}
