//
//  CustomCellDelegate.swift
//  MiniApp
//
//  Created by Danil Komarov on 07.09.2024.
//

import UIKit

protocol CustomCellDelegate: AnyObject {
    func didTapExpandButton(in cell: UICollectionViewCell)
}
