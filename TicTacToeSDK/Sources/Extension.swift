//
//  Extension.swift
//  MiniApp
//
//  Created by Danil Komarov on 07.09.2024.
//

import UIKit

extension TicTacToeView {
    func showToast(message: String, duration: TimeInterval = 3.0) {
        let toastView = UIView(frame: CGRect.zero)
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastView.layer.cornerRadius = 10
        toastView.clipsToBounds = true

        let messageLabel = UILabel(frame: CGRect.zero)
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 14.0)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        
        toastView.addSubview(messageLabel)
        self.addSubview(toastView)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -10),
            messageLabel.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            toastView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            toastView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            toastView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50)
        ])
        
        toastView.alpha = 0.0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastView.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                toastView.alpha = 0.0
            }) { _ in
                toastView.removeFromSuperview()
            }
        }
    }
}
