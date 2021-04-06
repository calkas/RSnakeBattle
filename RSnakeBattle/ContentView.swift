//
//  ContentView.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 14/03/2021.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        GameEngine()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
