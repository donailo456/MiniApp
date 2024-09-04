//
//  AppCoordinator.swift
//  MiniApp
//
//  Created by Danil Komarov on 03.09.2024.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol?
    var childer: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        debugPrint("Start Coordinator")
        showMainVC()
    }
    

    

    
    private func showMainVC() {
        let mainVC = MainViewController()
        let mainViewModel = MainViewModel.init()
        
        mainViewModel.coordinator = self
        mainVC.viewModel = mainViewModel
        
        navigationController.pushViewController(mainVC, animated: true)
    }
}
