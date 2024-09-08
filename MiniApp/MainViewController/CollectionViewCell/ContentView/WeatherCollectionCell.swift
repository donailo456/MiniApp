//
//  WeatherCollectionCell.swift
//  MiniApp
//
//  Created by Danil Komarov on 03.09.2024.
//

import UIKit
import WeatherSDK

final class WeatherCollectionCell: UICollectionViewCell {
    
    // MARK: - Internal properties
    
    static let identifire = "WeatherCollectionCell"
    weak var delegate: CustomCellDelegate?
    var selectedAnswer: ((String?) -> Void)?
    
    // MARK: - Private properties
    
    private var weatherViewBottomAncor: NSLayoutConstraint?
    private var weatherViewHeightAncor: NSLayoutConstraint?
    
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
        view.addSubview(weatherView)
        return view
    }()
    
    private lazy var weatherView: WeatherView = {
        let view = WeatherView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var fullScreenButton: FullScreenButton = {
       var button = FullScreenButton()
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
    
    // MARK: - Internal Methods
    
    func configure(with viewModel: MainCellModel?) {
        titleLabel.text = viewModel?.type?.title
        if let data = viewModel?.data {
            switch data {
            case .weather(let weatherData):
                weatherView.updateWeatherDisplay(temperature: weatherData.temp ?? 0.0, description: weatherData.description ?? "", city: weatherData.city ?? "")
            default: break
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        self.contentView.addSubview(cellHeader)
        self.contentView.addSubview(cellContent)
        setupConstraint()
        setupContentView()
        setTarget()
    }
    
    private func setupConstraint() {
        weatherViewBottomAncor = weatherView.bottomAnchor.constraint(equalTo: cellContent.bottomAnchor, constant: -10)
        weatherViewHeightAncor = weatherView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2 - UIScreen.main.bounds.height / 8 )
        weatherViewBottomAncor?.priority = .defaultHigh
        weatherViewHeightAncor?.priority = .defaultHigh
        
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
            
            weatherView.topAnchor.constraint(equalTo: cellContent.topAnchor, constant: 5),
            weatherView.trailingAnchor.constraint(equalTo: cellContent.trailingAnchor, constant: -10),
            weatherView.leadingAnchor.constraint(equalTo: cellContent.leadingAnchor, constant: 10),
        ])
    }
    
    private func updateCell() {
        weatherViewBottomAncor?.isActive = isSelected
        weatherViewHeightAncor?.isActive = isSelected
    }
    
    private func setTarget() {
        fullScreenButton.addTarget(self, action: #selector(fullScreenAction), for: .touchUpInside)
    }
    
    @objc
    private func fullScreenAction() {
        delegate?.didTapExpandButton(in: self)
    }
}
