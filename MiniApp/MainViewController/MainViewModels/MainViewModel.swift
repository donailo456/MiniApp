//
//  MainViewModel.swift
//  MiniApp
//
//  Created by Danil Komarov on 03.09.2024.
//

import UIKit
import CoreLocation

final class MainViewModel: NSObject {
    weak var coordinator: AppCoordinator!
    var onDataReload: (([MainCellModel]) -> Void)?
    var onCity: ((String?) -> Void)?

    
    private var dataSource: [MainCellModel] = []
    private var networkService = NetworkService()
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    private let geoCoder = CLGeocoder()
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func dataRelaod() {
        setupLocation()
        
        dataSource.append(MainCellModel(type: .ticTacToeCell, title: "Крестики/Нолики", data: nil))
        dataSource.append(MainCellModel(type: .weatherCell, title: "Погода", data: nil))
        dataSource.append(MainCellModel(type: .cityCell, title: "Текущий город", data: nil))
        dataSource.append(MainCellModel(type: .ticTacToeCell, title: "Крестики/Нолики", data: nil))
        dataSource.append(MainCellModel(type: .weatherCell, title: "Погода", data: nil))
        dataSource.append(MainCellModel(type: .ticTacToeCell, title: "Крестики/Нолики", data: nil))
        dataSource.append(MainCellModel(type: .cityCell, title: "Текущий город", data: nil))
        dataSource.append(MainCellModel(type: .cityCell, title: "Текущий город", data: nil))
        dataSource.append(MainCellModel(type: .ticTacToeCell, title: "Крестики/Нолики", data: nil))
        dataSource.append(MainCellModel(type: .weatherCell, title: "Погода", data: nil))
        
        DispatchQueue.main.async {
            self.onDataReload?(self.dataSource)
        }
    }
    
    func showFullScreenVC(data: MainCellModel) {
//        coordinator.startFullSreenView()
        coordinator.showFullScreenVC(data: data)
    }
    
    private func getCurrentWeather(_ lat: String?, _ lon: String?) {
        let request = WeatherRouter.getCurrentWeather(lat: lat, lon: lon)
        networkService.getCurrentWeather(request: request) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self.mapWeatherData(data: weather)
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
    
    private func mapWeatherData(data: CurrentWeather?) {
        guard let data = data else { return }
        let temp = data.main?.temp
        let description = data.weather?.first?.description
        let city = data.name
        
        let weatherModel = WeatherCellModel(temp: temp, description: description, city: city)
        let cityModel = CityCellModel(city: city)
        
        for i in 0..<dataSource.count {
            if dataSource[i].type == .weatherCell, dataSource[i].data == nil {
                dataSource[i].data = .weather(weatherModel)
            } else if dataSource[i].type == .cityCell, dataSource[i].data == nil {
                dataSource[i].data = .city(cityModel)
            }
        }
        
        DispatchQueue.main.async {
            self.onDataReload?(self.dataSource)
        }
    }
    
    //MARK: - Location
    
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension MainViewModel: CLLocationManagerDelegate {
    
    private func requestWeatherForLocation(_ location: CLLocation) {
        let lon = location.coordinate.longitude
        let lat = location.coordinate.latitude
        
        geoCoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first else {
                return
            }
            
            if let city = placemark.locality {
                self?.onCity?(city)
            }
        }
        
        getCurrentWeather(String(lat), String(lon))
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.first {
            self.currentLocation = currentLocation
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation(currentLocation)
        }
    }
}
