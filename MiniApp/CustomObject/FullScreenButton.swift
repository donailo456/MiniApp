//
//  FullScreenButton.swift
//  MiniApp
//
//  Created by Danil Komarov on 08.09.2024.
//

import UIKit

final class FullScreenButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let margin: CGFloat = 20
        let area = bounds.insetBy(dx: -margin, dy: -margin)
        return area.contains(point)
    }
}
