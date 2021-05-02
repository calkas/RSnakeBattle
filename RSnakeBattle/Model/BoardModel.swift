//
//  BoardModel.swift
//  RSnakeBattle
//
//  Created by Piotr Rybka on 30/03/2021.
//

import Foundation
import SwiftUI

struct BoardModel {
    let beginWidth = SystemSettings.shared.minScreenX
    let endWidth = SystemSettings.shared.maxScreenX
    let beginHeight = SystemSettings.shared.minScreenY + GameSettings.shared.yAdjustment + GameSettings.shared.yOffset
    let endHeight = SystemSettings.shared.maxScreenY - GameSettings.shared.yAdjustment
}
