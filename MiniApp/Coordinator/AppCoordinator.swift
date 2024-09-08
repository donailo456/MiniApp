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
    
    func startFullSreenView() {
        debugPrint("Start FullSreenView")
//        showFullScreenVC()
    }
    
    private func showMainVC() {
        let mainVC = MainViewController()
        let network = NetworkService()
        let mainViewModel = MainViewModel.init(networkService: network)
        
        mainViewModel.coordinator = self
        mainVC.viewModel = mainViewModel
        
        navigationController.navigationBar.barTintColor = UIColor.hexStringToUIColor(hex: "FFA000")
        navigationController.pushViewController(mainVC, animated: true)
        
    }
    
    func showFullScreenVC(data: MainCellModel) {
        let fullVC = FullScreenViewController()
        let fullViewModel = FullScreenViewModel.init(dataMainVC: data)
        
        fullViewModel.coordinator = self
        fullVC.viewModel = fullViewModel
        
        navigationController.pushViewController(fullVC, animated: true)
    }
}
