//
//  GameOverView.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 11/04/2021.
//

import SwiftUI

struct GameOverView: View {
    
    let score: Int
    let action: () -> ()
    
    var body: some View {
        ZStack {
            Image("board")
                .resizable()
                .blur(radius: 2.0)
        
            VStack(alignment: .center, spacing: 40) {
                Text("Game Over")
                    .font(.system(size: 40, weight: .black, design: .rounded))
                    .foregroundColor(.pink)
                Text("YOU SCORED:")
                    .font(.system(size: 25, weight: .black, design: .rounded))
                    .foregroundColor(.green)
                
                Text("\(score.description)")
                    .font(.system(size: 50, weight: .black, design: .rounded))
                    .foregroundColor(.green)
                
                Button(action: action, label: {
                    Text("Once Again?")
                        .font(.system(size: 25, weight: .black, design: .rounded))
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(40)
                })
                
                Spacer()
            }.offset(y: 70)
        }.ignoresSafeArea()
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(score: 1234) {}
    }
}
