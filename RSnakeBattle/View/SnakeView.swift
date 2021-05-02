//
//  SnakeModelView.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 26/03/2021.
//

import SwiftUI

struct SnakeView: View {
    
    @ObservedObject var snake: SnakeViewModel
    
    var body: some View {
        ZStack {
            ForEach (0..<snake.snakeModel.length, id: \.self) { index in
                if index == 0 {
                    drawHead()
                }
                else if index == snake.snakeModel.length - 1 {
                    drawTail()
                }
                else {
                    drawBody(index: index)
                }
            }
        }
    }
    
    private func drawHead() -> some View {
        return Image("snakeHeadBigEyes")
            .resizable()
            .frame(width: snake.snakeModel.width, height: snake.snakeModel.heigh)
            .position(snake.snakeModel.body[0].position)
            .shadow(radius: 10)
    }
    
    private func drawBody(index: Int) -> some View {
        return Rectangle()
            .frame(width: snake.snakeModel.width, height: snake.snakeModel.heigh)
            .position(snake.snakeModel.body[index].position)
            .foregroundColor(Color.pink).shadow(radius: 10)
    }
    
    private func drawTail() -> some View {
        return Rectangle()
            .frame(width: snake.snakeModel.width, height: snake.snakeModel.heigh)
            .position(snake.snakeModel.body[snake.snakeModel.body.count - 1].position)
            .foregroundColor(Color.pink).shadow(radius: 10)
    }
}

struct SnakeModelView_Previews: PreviewProvider {
    static var previews: some View {
        let snakeModel = SnakeViewModel(startSnakePosition: GameSettings.shared.snakeStartingPoint)
        SnakeView(snake: snakeModel)
    }
}
