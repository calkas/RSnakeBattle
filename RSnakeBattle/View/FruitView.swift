//
//  FruitModelView.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 05/04/2021.
//

import SwiftUI

struct FruitView: View {

    @ObservedObject var fruitViewModel: FruitViewModel
    
    var body: some View {
        ZStack {
            Image("apple_fruit")
                .resizable()
                .frame(width: fruitViewModel.fruitModel.width, height: fruitViewModel.fruitModel.heigh)
                .position(fruitViewModel.fruitModel.coordinates)
                .shadow(radius: 10)
        }
    }
}

struct FruitModelView_Previews: PreviewProvider {
    static var previews: some View {
        let fruit = FruitViewModel(workingCoords: CGPoint(x: 100, y: 100))
        FruitView(fruitViewModel: fruit)
    }
}
