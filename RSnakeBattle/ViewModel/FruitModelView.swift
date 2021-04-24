//
//  FruitModelView.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 05/04/2021.
//

import SwiftUI

struct FruitModelView: View {

    @ObservedObject var fruit: FruitModel
    
    var body: some View {
        ZStack {
            Image("apple_fruit")
                .resizable()
                .frame(width: fruit.width, height: fruit.heigh)
                .position(fruit.coordinates)
                .shadow(radius: 10)
        }
    }
}

struct FruitModelView_Previews: PreviewProvider {
    static var previews: some View {
        let fruit = FruitModel(workingCoords: CGPoint(x: 100, y: 100))
        FruitModelView(fruit: fruit)
    }
}
