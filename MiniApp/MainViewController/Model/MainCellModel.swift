//
//  MainCellModel.swift
//  MiniApp
//
//  Created by Danil Komarov on 03.09.2024.
//

import UIKit

enum CellDataType: Hashable {
    case weather(WeatherCellModel)
    case city(CityCellModel)
}

struct MainCellModel: Hashable {
    let id = UUID()
    var type: CellType?
    var data: CellDataType?
}

struct WeatherCellModel: Hashable {
    var temp: Double?
    var description: String?
    var city: String?
    var maxTemp: Double?
    var minTemp: Double?
}

struct CityCellModel: Hashable {
    var city: String?
}
