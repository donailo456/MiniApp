//
//  WeatherCollectionCell.swift
//  MiniApp
//
//  Created by Danil Komarov on 03.09.2024.
//

import UIKit
import WeatherSDK

final class WeatherCollectionCell: UICollectionViewCell {
    
    static let identifire = "WeatherCollectionCell"
    
    var selectedAnswer: ((String?) -> Void)?
    
    private var weatherViewBottomAncor: NSLayoutConstraint?
    private var weatherViewHeightAncor: NSLayoutConstraint?
    
    private lazy var cellHeader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        view.addSubview(titleLabel)
        return view
    }()
    
    private lazy var weatherView: WeatherView = {
        let view = WeatherView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cellContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(weatherView)
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return label
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
    
    private func setupViews() {
//        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(cellHeader)
        self.contentView.addSubview(cellContent)
        setupConstraint()
       
    }
    
    private func setupConstraint() {
        weatherViewBottomAncor = weatherView.bottomAnchor.constraint(equalTo: cellContent.bottomAnchor, constant: -10)
        weatherViewHeightAncor = weatherView.heightAnchor.constraint(equalToConstant: 200)
        weatherViewBottomAncor?.priority = .defaultHigh
        weatherViewHeightAncor?.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            cellHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellHeader.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60),
            cellHeader.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: cellHeader.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: cellHeader.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: cellHeader.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: cellHeader.bottomAnchor),
            
            cellContent.topAnchor.constraint(equalTo: cellHeader.bottomAnchor),
            cellContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            weatherView.topAnchor.constraint(equalTo: cellContent.topAnchor, constant: 5),
            weatherView.trailingAnchor.constraint(equalTo: cellContent.trailingAnchor, constant: -10),
            weatherView.leadingAnchor.constraint(equalTo: cellContent.leadingAnchor, constant: 10),
        ])
    }
    
    private func updateCell() {
        weatherViewBottomAncor?.isActive = isSelected
        weatherViewHeightAncor?.isActive = isSelected
        
        weatherView.setActiveConstraint(isSelected: !isSelected)
    }
    
    func configure(with viewModel: MainCellModel?) {
//        titleLabel.text = viewModel?.title
        weatherView.updateWeatherDisplay(temperature: Int(viewModel?.data?.temp ?? 0.0), description: viewModel?.data?.description ?? "")
    }
}
