//
//  FruitModel.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 04/04/2021.
//
import SwiftUI
import Foundation


struct FruitModel {
    let width = GameSettings.shared.objectWidth
    let heigh = GameSettings.shared.objectHeigh
    var coordinates = GameSettings.shared.fruitStartingPoint
}
