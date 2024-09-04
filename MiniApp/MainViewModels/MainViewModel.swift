//
//  MainViewModel.swift
//  MiniApp
//
//  Created by Danil Komarov on 03.09.2024.
//

import UIKit

final class MainViewModel {
    weak var coordinator: AppCoordinator!
//    var onDataReload: ((CellData?) -> Void)?
    
    private var dataSource: [MainCellModel]?
    
    func createData(complition: ([MainCellModel]?) -> Void) {
        dataSource = [MainCellModel(type: .mainTemp, title: "1"), MainCellModel(type: .weatherCell, title: "1")]
        complition(dataSource)
    }
}
