//
//  FullScreenViewModel.swift
//  MiniApp
//
//  Created by Danil Komarov on 07.09.2024.
//

import UIKit

final class FullScreenViewModel: NSObject {
    weak var coordinator: AppCoordinator!
    var dataMainVC: MainCellModel?
    
    init(dataMainVC: MainCellModel?) {
        self.dataMainVC = dataMainVC
    }
    
    func mapType() -> CellType? {
        return dataMainVC?.type
    }
}
