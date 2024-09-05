import UIKit

public final class WeatherView: UIView {

    private lazy var temperatureLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "33"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sunny"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var mainStack: UIStackView = {
       var stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(temperatureLabel)
        stack.addArrangedSubview(descriptionLabel)
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public func setActiveConstraint(isSelected: Bool) {
        mainStack.isHidden = isSelected
    }
    
    public func updateWeatherDisplay(temperature: Int, description: String) {
        temperatureLabel.text = "\(temperature)°C"
        descriptionLabel.text = description
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
