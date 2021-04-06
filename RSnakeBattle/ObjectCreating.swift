//
//  ObjectCreating.swift
//  
//
//  Created by Piotr Rybka on 14/03/2021.
//

import SwiftUI


protocol ObjectCreating {
    associatedtype V: View
    func create(posX: CGFloat, posY: CGFloat, width: CGFloat, height: CGFloat) -> V
}

extension ObjectCreating {
    func create(position: CGPoint, width: CGFloat = 20, height: CGFloat = 20) -> some View {
        return Rectangle()
            .frame(width: width, height: height)
            .position(position)
            .foregroundColor(.pink)
    }
}
