//
//  CoordinatorProtocol.swift
//  MiniApp
//
//  Created by Danil Komarov on 03.09.2024.
//

import UIKit

protocol CoordinatorProtocol {
    var parentCoordinator: CoordinatorProtocol? { get set }
    var childer: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
