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
    
    func addTicTacToe() {
        dataSource.append(MainCellModel(type: .ticTacToe, title: "Крестики/Нолики", data: nil))
        self.onDataReload?(self.dataSource)
    }
    
    private func getCurrentWeather(_ lat: String?, _ lon: String?) {
        let request = WeatherRouter.getCurrentWeather(lat: lat, lon: lon).urlRequest
        networkService.getCurrentWeather(request: request, lat: lat, lon: lon) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    let temp = weather?.main?.temp
                    let description = weather?.weather?.first?.description
                    let city = weather?.name
                    self.dataSource.append(MainCellModel(type: .weatherCell, title: "Погода", data: WeatherCellModel(temp: temp, description: description, city: city)))
                    self.onDataReload?(self.dataSource)
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
    
    //MARK: - Location
    
    func setupLocation() {
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
