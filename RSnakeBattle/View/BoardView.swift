//
//  BoardModelView.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 03/04/2021.
//

import SwiftUI

struct BoardView: View {
    
    @ObservedObject var boardViewModel: BoardViewModel
    
    var body: some View {
        ZStack {
            Image("board")
                .resizable()
        }.frame(width: boardViewModel.boardModel.endWidth - boardViewModel.boardModel.beginWidth, height: boardViewModel.boardModel.endHeight).offset(y: GameSettings.shared.yOffset)
    }
}

struct BoardModelView_Previews: PreviewProvider {
    static var previews: some View {
        let boardViewModel = BoardViewModel()
        BoardView(boardViewModel: boardViewModel)
    }
}
