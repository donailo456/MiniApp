//
//  ExtensionCell.swift
//  MiniApp
//
//  Created by Danil Komarov on 07.09.2024.
//

import UIKit

extension UICollectionViewCell {
    func setupContentView() {
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}
