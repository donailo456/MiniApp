//
//  Cells.swift
//  MiniApp
//
//  Created by Danil Komarov on 03.09.2024.
//

import UIKit

enum CellType: String, CaseIterable {
    case cityCell
    case weatherCell
    case ticTacToeCell
    
    var title: String {
        switch self {
        case .ticTacToeCell:
            return "Крестики/Нолики"
        case .weatherCell:
            return "Погода"
        case .cityCell:
            return "Текущий город"
        }
    }
}
