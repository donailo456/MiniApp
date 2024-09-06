//
//  MainCellModel.swift
//  MiniApp
//
//  Created by Danil Komarov on 03.09.2024.
//

import UIKit

protocol CellProtocol {}

struct MainCellModel: Hashable {
    var type: CellType?
    var title: String?
    let data: WeatherCellModel?
}

struct WeatherCellModel: Hashable {
    var temp: Double?
    var description: String?
    var city: String?
}
