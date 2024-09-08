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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ticTacToeView: TicTacToeView = {
        let view = TicTacToeView(markSize: view.bounds.height / 3 - 200)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getType()
    }
    
    private func getType() {
        guard let type = viewModel?.mapType() else { return }
        switch type {
        case .weatherCell:
            addView(sabview: weatherView)
        case .cityCell:
            debugPrint("City")
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

    
}
