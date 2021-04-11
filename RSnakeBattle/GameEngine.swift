//
//  GameEngine.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 21/03/2021.
//

import SwiftUI

struct GameEngine: View {
    
    @ObservedObject var snake = SnakeModel(startSnakePosition: GameSettings.shared.snakeStartingPoint)
    let board = BoardModel()
    @ObservedObject var fruit = FruitModel(workingCoords: CGPoint(x: CGFloat(SystemSettings.shared.maxScreenX - GameSettings.shared.xAdjustment), y: CGFloat(SystemSettings.shared.maxScreenY - GameSettings.shared.yAdjustment)))
    
    @ObservedObject var scoreBoard = ScoreBoardModel()
    
    @State private var snakeMove: SnakeMove = .up
    @State private var isGameStarted = false
    @State private var gameTimer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    @State var isGameOver = false
    
    var body: some View {
        VStack {
            ZStack {
                if isGameOver {
                    VStack {
                        GameOverView(score: scoreBoard.score, action: { self.resetGame() })
                    }
                }
                else {
                    
                    BoardModelView(board: board)
                    SnakeModelView(snake: snake)
                    FruitModelView(fruit: fruit)
                    Text("Score: \(scoreBoard.score)")
                        .font(.system(size: 20, weight: .black, design: .rounded))
                        .foregroundColor(.pink).position(x:SystemSettings.shared.maxScreenX - 75, y: SystemSettings.shared.minScreenY + 5)
                }
            }

        }.gesture(DragGesture(minimumDistance: CGFloat(0)).onEnded({ g in
            if !isGameStarted {
                scoreBoard.reset()
                startGameTimer()
                isGameStarted = true
            }
            determineSnakeDirection(clickScreenPoint: g.location)
        })).onReceive(gameTimer, perform: { _ in
            
            if !isGameOver {
                snake.move(move: snakeMove)
                if board.isCollision(point: snake.headPosition) || snake.isCollisionDetected {
                    isGameOver = true
                }
                
                else if fruit.wasEaten(objPoint: snake.headPosition, objWidth: snake.width, objHeight: snake.heigh) {
                    scoreBoard.update()
                    snake.addBodyElement()
                    fruit.create()
                }
                else {
                    // Do Nothing
                }
            }
            
        }).onAppear() {
            stopGameTimer()
        }
    }
    
    
    private func determineSnakeDirection(clickScreenPoint: CGPoint)
    {
        let dXFromObjToClick = abs(clickScreenPoint.x - snake.headPosition.x)
        let dYFromObjToClick = abs(clickScreenPoint.y - snake.headPosition.y)
        
        if clickScreenPoint.x > snake.headPosition.x && dXFromObjToClick > dYFromObjToClick {
            snakeMove = .right
        }
        else if clickScreenPoint.x < snake.headPosition.x && dXFromObjToClick > dYFromObjToClick {
            snakeMove = .left
        }
        else if clickScreenPoint.y > snake.headPosition.y && dYFromObjToClick > dXFromObjToClick {
            snakeMove = .down
        }
        else if clickScreenPoint.y < snake.headPosition.y && dYFromObjToClick > dXFromObjToClick {
            snakeMove = .up
        }
        else {
            //Do Nothing
        }
    }

    private func stopGameTimer() {
        gameTimer.upstream.connect().cancel()
    }

    private func startGameTimer() {
        gameTimer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    }
    
    func resetGame() {
        snake.reset(startSnakePosition: GameSettings.shared.snakeStartingPoint)
        isGameOver.toggle()
        stopGameTimer()
        isGameStarted.toggle()
    }
}

struct GameEngine_Previews: PreviewProvider {
    static var previews: some View {
        GameEngine()
    }
}
