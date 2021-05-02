//
//  Game.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 21/03/2021.
//

import SwiftUI

struct Game: View {

    @StateObject var boardViewModel = BoardViewModel()
    @StateObject var snake = SnakeModel(startSnakePosition: GameSettings.shared.snakeStartingPoint)
    @StateObject var fruit = FruitModel(workingCoords: CGPoint(x: SystemSettings.shared.maxScreenX - GameSettings.shared.xAdjustment, y: SystemSettings.shared.maxScreenY - (GameSettings.shared.yAdjustment - GameSettings.shared.yOffset)))
    @StateObject var scoreBoardViewModel = ScoreBoardViewModel()
    
    @State private var snakeMove = SnakeMove.up
    @State private var isGameStarted = false
    @State private var isGameOver = false
    @State private var gameTimer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            ZStack {
                if isGameOver {
                    VStack {
                        GameOverView(score: scoreBoardViewModel.getScore(), action: { self.resetGame() })
                    }
                }
                else {
                    ScoreBoardView()
                    BoardView(boardViewModel: boardViewModel)
                    SnakeModelView(snake: snake)
                    FruitModelView(fruit: fruit)
                    
                }
            }

        }.gesture(DragGesture(minimumDistance: CGFloat(0)).onEnded({ g in
            if !isGameStarted {
                scoreBoardViewModel.reset()
                updateGameLevel()
                isGameStarted = true
            }
            determineSnakeDirection(clickScreenPoint: g.location)
        })).onReceive(gameTimer, perform: { _ in
            
            if !isGameOver {
                snake.move(snakeMove)
                if boardViewModel.isCollision(point: snake.headPosition) || snake.isCollisionDetected {
                    isGameOver = true
                }
                
                else if fruit.wasEaten(objPoint: snake.headPosition, objWidth: snake.width, objHeight: snake.heigh) {
                    scoreBoardViewModel.update()
                    snake.addLastBodyElement(snakeMove)
                    fruit.create()
                    updateGameLevel()
                }
                else {
                    // Do Nothing
                }
            }
            
        }).onAppear() {
            stopGameTimer()
        }.ignoresSafeArea()
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
    
    private func ScoreBoardView() -> some View {
        return Text("Score: \(scoreBoardViewModel.getScore())")
            .font(.system(size: 20, weight: .black, design: .rounded))
            .foregroundColor(.pink).position(x:SystemSettings.shared.maxScreenX - 70, y: SystemSettings.shared.minScreenY + GameSettings.shared.yOffset)
    }

    private func stopGameTimer() {
        gameTimer.upstream.connect().cancel()
    }

    private func startGameTimer(gameInterval: Double) {
        gameTimer = Timer.publish(every: gameInterval, on: .main, in: .common).autoconnect()
    }
    
    private func updateGameLevel() {
        stopGameTimer()
        switch scoreBoardViewModel.getScore() {
            case 0...9: startGameTimer(gameInterval: GameLevel.noob.rawValue)
            case 10...19: startGameTimer(gameInterval: GameLevel.normal.rawValue)
            case 20...49: startGameTimer(gameInterval: GameLevel.pro.rawValue)
            default: startGameTimer(gameInterval: GameLevel.hardcore.rawValue)
        }
    }
    
    func resetGame() {
        snake.reset(startSnakePosition: GameSettings.shared.snakeStartingPoint)
        stopGameTimer()
        isGameOver = false
        isGameStarted = false
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
