//
//  SnakeModelView.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 26/03/2021.
//

import SwiftUI


struct SnakeModelView: View {
    
    @ObservedObject var snake: SnakeModel
    
    var body: some View {
        ZStack {
            ForEach (0..<snake.length, id: \.self) { index in
                if index == 0 {
                    drawHead()
                }
                else if index == snake.length - 1 {
                    drawTail()
                }
                
                else {
                    drawBody(index: index)
                }
            }
        }
    }
    
    private func drawHead() -> some View {
        return Rectangle()
            .frame(width: snake.width, height: snake.heigh)
            .position(snake.body[0].position)
            .foregroundColor(Color.blue)
    }
    
    private func drawBody(index: Int) -> some View {
        return Rectangle()
            .frame(width: snake.width, height: snake.heigh)
            .position(snake.body[index].position)
            .foregroundColor(Color.pink)
    }
    
    private func drawTail() -> some View {

        return Rectangle()
            .frame(width: snake.width, height: snake.heigh)
            .position(snake.body[snake.body.count - 1].position)
            .foregroundColor(Color.black)
    }
    
}
    
   


struct SnakeModelView_Previews: PreviewProvider {
    static var previews: some View {
        let snake = SnakeModel(startSnakePosition: CGPoint(x: 100, y: 50))
        SnakeModelView(snake: snake)
    }
}
