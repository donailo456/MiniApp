//
//  MainCollectionCell.swift
//  MiniApp
//
//  Created by Danil Komarov on 03.09.2024.
//

import UIKit

final class CityCollectionCell: UICollectionViewCell {
    
    static let identifire = "MainCollectionViewCell"
    weak var delegate: CustomCellDelegate?
    var selectedAnswer: ((String?) -> Void)?
    
    private var labelBottomAnchor: NSLayoutConstraint?
    private var labelHeightAnchor: NSLayoutConstraint?
    
    override var isSelected: Bool {
        didSet {
            updateCell()
        }
    }
    
    private lazy var cellHeader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        view.addSubview(fullScreenButton)
        return view
    }()
    
    private lazy var cellContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cityLabel)
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
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.text = "Москва"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var fullScreenButton: UIButton = {
       var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "FullScreen"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContentView()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        setupContentView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: MainCellModel?) {
        titleLabel.text = viewModel?.title
        let data = viewModel?.data
        switch data {
        case .city(let cityModel):
            cityLabel.text = cityModel.city
        default:
            debugPrint("")
        }
    }
    
    private func setupViews() {
        self.contentView.addSubview(cellHeader)
        self.contentView.addSubview(cellContent)
        setupConstraint()
        setupContentView()
        setTarget()
    }
    
    private func setupConstraint() {
        labelBottomAnchor = cityLabel.bottomAnchor.constraint(equalTo: cellContent.bottomAnchor, constant: -10)
        labelHeightAnchor = cityLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2 - UIScreen.main.bounds.height / 8 )
        labelBottomAnchor?.priority = .defaultHigh
        labelHeightAnchor?.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            cellHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellHeader.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60),
            cellHeader.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 8),
            
            titleLabel.topAnchor.constraint(equalTo: cellHeader.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: cellHeader.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: cellHeader.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: cellHeader.bottomAnchor),
            
            fullScreenButton.topAnchor.constraint(equalTo: cellHeader.topAnchor, constant: 15),
            fullScreenButton.trailingAnchor.constraint(equalTo: cellHeader.trailingAnchor, constant: -15),
            fullScreenButton.heightAnchor.constraint(equalToConstant: 25),
            fullScreenButton.widthAnchor.constraint(equalToConstant: 25),
            
            cellContent.topAnchor.constraint(equalTo: cellHeader.bottomAnchor),
            cellContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: cellContent.topAnchor, constant: 5),
            cityLabel.trailingAnchor.constraint(equalTo: cellContent.trailingAnchor, constant: -10),
            cityLabel.leadingAnchor.constraint(equalTo: cellContent.leadingAnchor, constant: 10),
        ])
    }
    
    private func updateCell() {
        labelBottomAnchor?.isActive = isSelected
        labelHeightAnchor?.isActive = isSelected
    }
    
    private func setTarget() {
        fullScreenButton.addTarget(self, action: #selector(fullScreenAction), for: .touchUpInside)
    }
    
    @objc
    private func fullScreenAction() {
        delegate?.didTapExpandButton(in: self)
    }
}
