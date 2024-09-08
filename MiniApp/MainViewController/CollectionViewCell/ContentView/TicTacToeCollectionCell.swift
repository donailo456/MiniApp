//
//  TicTacToeCell.swift
//  MiniApp
//
//  Created by Danil Komarov on 06.09.2024.
//

import UIKit
import TicTacToeSDK

final class TicTacToeCollectionCell: UICollectionViewCell {
    
    static let identifire = "TicTacToeCollectionCell"
    weak var delegate: CustomCellDelegate?
    var selectedAnswer: ((String?) -> Void)?
    
    private var ticViewBottomAncor: NSLayoutConstraint?
    private var ticViewHeightAncor: NSLayoutConstraint?
    
    private lazy var cellHeader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        view.addSubview(fullScreenButton)
        return view
    }()
    
    private lazy var ticTacToeView: TicTacToeView = {
        let view = TicTacToeView(markSize: 50)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cellContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ticTacToeView)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var fullScreenButton: UIButton = {
       var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "FullScreen"), for: .normal)
        return button
    }()
    
    override var isSelected: Bool {
        didSet {
            updateCell()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: MainCellModel?) {
        titleLabel.text = viewModel?.type?.title
    }
    
    private func setupViews() {
        self.contentView.addSubview(cellHeader)
        self.contentView.addSubview(cellContent)
        setupConstraint()
        setupContentView()
        setTarget()
    }
    
    private func setupConstraint() {
        ticViewBottomAncor = ticTacToeView.bottomAnchor.constraint(equalTo: cellContent.bottomAnchor, constant: -10)
        ticViewHeightAncor = ticTacToeView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2 - UIScreen.main.bounds.height / 8 )
        ticViewBottomAncor?.priority = .defaultHigh
        ticViewHeightAncor?.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            cellHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellHeader.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60),
            cellHeader.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 8),
            
            titleLabel.topAnchor.constraint(equalTo: cellHeader.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: cellHeader.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: fullScreenButton.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: cellHeader.bottomAnchor),
            
            fullScreenButton.topAnchor.constraint(equalTo: cellHeader.topAnchor, constant: 15),
            fullScreenButton.trailingAnchor.constraint(equalTo: cellHeader.trailingAnchor, constant: -15),
            fullScreenButton.heightAnchor.constraint(equalToConstant: 25),
            fullScreenButton.widthAnchor.constraint(equalToConstant: 25),
            
            cellContent.topAnchor.constraint(equalTo: cellHeader.bottomAnchor),
            cellContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            ticTacToeView.topAnchor.constraint(equalTo: cellContent.topAnchor, constant: 5),
            ticTacToeView.trailingAnchor.constraint(equalTo: cellContent.trailingAnchor, constant: -10),
            ticTacToeView.leadingAnchor.constraint(equalTo: cellContent.leadingAnchor, constant: 10),
        ])
    }
    
    private func updateCell() {
        ticViewBottomAncor?.isActive = isSelected
        ticViewHeightAncor?.isActive = isSelected
        
        ticTacToeView.resetGame()
    }
    
    private func setTarget() {
        fullScreenButton.addTarget(self, action: #selector(fullScreenAction), for: .touchUpInside)
    }
    
    @objc
    private func fullScreenAction() {
        delegate?.didTapExpandButton(in: self)
    }
}
