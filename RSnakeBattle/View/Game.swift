//
//  Game.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 21/03/2021.
//

import SwiftUI

struct Game: View {

    @StateObject var boardViewModel = BoardViewModel()
    @StateObject var snakeViewModel = SnakeViewModel(startSnakePosition: GameSettings.shared.snakeStartingPoint)
    @StateObject var fruitViewModel = FruitViewModel(workingCoords: CGPoint(x: SystemSettings.shared.maxScreenX - GameSettings.shared.xAdjustment, y: SystemSettings.shared.maxScreenY - (GameSettings.shared.yAdjustment - GameSettings.shared.yOffset)))
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
                    SnakeView(snake: snakeViewModel)
                    FruitView(fruitViewModel: fruitViewModel)
                    
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
                snakeViewModel.move(snakeMove)
                if boardViewModel.isCollision(point: snakeViewModel.snakeModel.headPosition) || snakeViewModel.isCollisionDetected {
                    isGameOver = true
                }
                
                else if fruitViewModel.wasEaten(objPoint: snakeViewModel.snakeModel.headPosition, objWidth: snakeViewModel.snakeModel.width, objHeight: snakeViewModel.snakeModel.heigh) {
                    scoreBoardViewModel.update()
                    snakeViewModel.addLastBodyElement(snakeMove)
                    fruitViewModel.create()
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
        let dXFromObjToClick = abs(clickScreenPoint.x - snakeViewModel.snakeModel.headPosition.x)
        let dYFromObjToClick = abs(clickScreenPoint.y - snakeViewModel.snakeModel.headPosition.y)
        
        if clickScreenPoint.x > snakeViewModel.snakeModel.headPosition.x && dXFromObjToClick > dYFromObjToClick {
            snakeMove = .right
        }
        else if clickScreenPoint.x < snakeViewModel.snakeModel.headPosition.x && dXFromObjToClick > dYFromObjToClick {
            snakeMove = .left
        }
        else if clickScreenPoint.y > snakeViewModel.snakeModel.headPosition.y && dYFromObjToClick > dXFromObjToClick {
            snakeMove = .down
        }
        else if clickScreenPoint.y < snakeViewModel.snakeModel.headPosition.y && dYFromObjToClick > dXFromObjToClick {
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
        snakeViewModel.reset(startSnakePosition: GameSettings.shared.snakeStartingPoint)
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
