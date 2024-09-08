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
    
    func getTypeCell() -> CellType? {
        dataMainVC?.type
    }
    
    func getDataCell() -> CellDataType? {
        dataMainVC?.data
    }
}
