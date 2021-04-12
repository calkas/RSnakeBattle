//
//  BoardModelView.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 03/04/2021.
//

import SwiftUI

struct BoardModelView: View {
    
    let board: BoardModel
    
    var body: some View {
        ZStack {
            Image("board")
                .resizable()
        }.frame(width: board.width, height: board.height)
    }
}

struct BoardModelView_Previews: PreviewProvider {
    static var previews: some View {
        let board = BoardModel()
        BoardModelView(board: board)
    }
}
