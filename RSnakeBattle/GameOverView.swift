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
        VStack(alignment: .center, spacing: 20) {
            Text("Game Over")
                .font(.system(size: 40, weight: .black, design: .rounded))
                .foregroundColor(.pink)
            Text("YOU SCORED:")
                .font(.system(size: 20, weight: .black, design: .rounded))
                .foregroundColor(.green)
            
            Text("\(score.description)")
                .font(.system(size: 50, weight: .black, design: .rounded))
                .foregroundColor(.green)
            
            Group {
                Button(action: action, label: {
                    Text("Once Again")
                        .font(.system(size: 25, weight: .black, design: .rounded))
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                })
            }.padding()
            Spacer()
        }
        .background(Color.white)
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(score: 1233333) {}
    }
}
