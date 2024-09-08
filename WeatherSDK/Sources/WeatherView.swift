import UIKit

public final class WeatherView: UIView {

    private lazy var temperatureLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "33°C"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ясно"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Москва"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
       var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(temperatureLabel)
        stack.addArrangedSubview(descriptionLabel)
        stack.addArrangedSubview(cityLabel)
        return stack
    }()
    
    private lazy var maxTempLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Max. ↑: 35°C"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var minTempLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Min. ↓: 25°C"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private lazy var tempStack: UIStackView = {
       var stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(minTempLabel)
        stack.addArrangedSubview(maxTempLabel)
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public func setupFullScreenView() {
        temperatureLabel.textColor = .white
        temperatureLabel.font = .systemFont(ofSize: 30, weight: .bold)
        descriptionLabel.textColor = .white
        descriptionLabel.font = .systemFont(ofSize: 25, weight: .medium)
        cityLabel.textColor = .white
        descriptionLabel.font = .systemFont(ofSize: 25, weight: .medium)
        
        mainStack.addArrangedSubview(tempStack)
        
    }
    
    public func updateWeatherDisplay(temperature: Double, description: String, city: String) {
        temperatureLabel.text = "\(temperature)°C"
        descriptionLabel.text = description
        cityLabel.text = city
    }
    
    public func updateTemp(maxTemp: Double, minTemp: Double) {
        minTempLabel.text = "Min. ↓: \(minTemp)°C"
        maxTempLabel.text = "Max. ↑: \(maxTemp)°C"
    }

    private func setupView() {
        addSubview(mainStack)
        setConstraint()
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
