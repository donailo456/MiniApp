//
//  ExtensionCell.swift
//  MiniApp
//
//  Created by Danil Komarov on 07.09.2024.
//

import UIKit

extension UICollectionViewCell {
    func setupContentView() {
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 6
        
        self.layer.masksToBounds = false
        
        self.contentView.backgroundColor = .white 
    }
}
