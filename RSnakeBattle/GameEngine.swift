//
//  GameEngine.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 21/03/2021.
//

import SwiftUI

struct GameEngine: View {
    
    @ObservedObject var snake = SnakeModel(startSnakePosition: GameSettings.shared.snakeStartingPoint)
    
    @ObservedObject var board = BoardModel()
    @ObservedObject var fruit = FruitModel(workingCoords: CGPoint(x: CGFloat(SystemSettings.shared.maxScreenX - GameSettings.shared.xAdjustment), y: CGFloat(SystemSettings.shared.maxScreenY - GameSettings.shared.yAdjustment)))
    
    @State var snakeMove: SnakeMove = .up
    @State var gameOver = false
    
    let gameTimer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()


    var body: some View {
        VStack {
            ZStack {
                if gameOver {
                    VStack {
                        Text("GAME OVER")
                    }
                }
                else {
                    BoardModelView(board: board)
                    SnakeModelView(snake: snake)
                    FruitModelView(fruit: fruit)
                }
            }

        }.gesture(DragGesture(minimumDistance: CGFloat(0)).onEnded({ g in
            determineSnakeDirection(clickScreenPoint: g.location)
        })).onReceive(gameTimer, perform: { _ in
            
            if !gameOver {
                snake.move(move: snakeMove)
                if(board.isCollision(point: snake.headPosition) || snake.isCollisionDetected) {
                    gameOver = true
                }
                
                else if(fruit.wasEaten(objPoint: snake.headPosition, objWidth: snake.width, objHeight: snake.heigh)) {
                    snake.addBodyElement()
                    fruit.create()
                }
                else {
                    // Do Nothing
                }
            }
            else {
                
            }
        })
    }
    
    
    private func determineSnakeDirection(clickScreenPoint: CGPoint)
    {
        let dXFromObjToClick = abs(clickScreenPoint.x - snake.headPosition.x)
        let dYFromObjToClick = abs(clickScreenPoint.y - snake.headPosition.y)
        
        if(clickScreenPoint.x > snake.headPosition.x  && dXFromObjToClick > dYFromObjToClick)
        {
            snakeMove = .right
        }
        else if(clickScreenPoint.x < snake.headPosition.x && dXFromObjToClick > dYFromObjToClick)
        {
            snakeMove = .left
        }
        
        else if(clickScreenPoint.y > snake.headPosition.y && dYFromObjToClick > dXFromObjToClick)
        {
            snakeMove = .down
        }
        else if(clickScreenPoint.y < snake.headPosition.y && dYFromObjToClick > dXFromObjToClick)
        {
            snakeMove = .up
        }
        else
        {
            //Do Nothing
        }
    }
}

struct GameEngine_Previews: PreviewProvider {
    static var previews: some View {
        GameEngine()
    }
}
