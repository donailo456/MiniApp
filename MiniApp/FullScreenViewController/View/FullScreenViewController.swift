//
//  FullScreenViewController.swift
//  MiniApp
//
//  Created by Danil Komarov on 07.09.2024.
//

import UIKit
import TicTacToeSDK
import WeatherSDK

final class FullScreenViewController: UIViewController {
    
    var viewModel: FullScreenViewModel?
    
    private lazy var weatherView: WeatherView = {
       let view = WeatherView()
        view.setupFullScreenView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ticTacToeView: TicTacToeView = {
        let view = TicTacToeView(markSize: view.bounds.height / 3 - 200)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.text = "Москва"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "FFA000")
        getType()
    }
    
    private func getType() {
        guard let type = viewModel?.getTypeCell() else { return }
        switch type {
        case .weatherCell:
            addView(sabview: weatherView)
            setData()
        case .cityCell:
            addView(sabview: cityLabel)
            setData()
        case .ticTacToeCell:
            addView(sabview: ticTacToeView)
        }
    }
    
    private func addView(sabview: UIView) {
        view.addSubview(sabview)
        
        NSLayoutConstraint.activate([
            sabview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            sabview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            sabview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            sabview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            sabview.widthAnchor.constraint(equalToConstant: view.bounds.width - 10),
        ])
    }
    
    private func setData() {
        guard let data = viewModel?.getDataCell() else { return }
        switch data {
        case .city(let cityData):
            cityLabel.text = cityData.city
        case .weather(let weatherData):
            let temp = weatherData.temp
            let description = weatherData.description
            let city = weatherData.city
            let maxTemp = weatherData.maxTemp
            let minTemp = weatherData.minTemp
            weatherView.updateWeatherDisplay(temperature: temp ?? 0.0, description: description ?? "", city: city ?? "")
            weatherView.updateTemp(maxTemp: maxTemp ?? 0.0, minTemp: minTemp ?? 0.0)
        }
    }
    
}
