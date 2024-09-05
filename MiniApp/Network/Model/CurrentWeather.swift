//
//  CurrentWeather.swift
//  MiniApp
//
//  Created by Danil Komarov on 05.09.2024.
//

import Foundation

// MARK: - CurrentWeather

struct CurrentWeather: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let main: Main?
    let name: String?
}

// MARK: - Coord

struct Coord: Codable {
    let lon, lat: Double?
}

// MARK: - Main

struct Main: Codable {
    let temp, temp_min, temp_max: Double?
}

// MARK: - Weather

struct Weather: Codable {
    let description, icon: String?
}
