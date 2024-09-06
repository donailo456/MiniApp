//
//  MainCollectionCell.swift
//  MiniApp
//
//  Created by Danil Komarov on 03.09.2024.
//

import UIKit

final class MainCollectionCell: UICollectionViewCell {
    
    static let identifire = "MainCollectionViewCell"
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
//        view.addSubview(titleLabel)
        view.backgroundColor = .green
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
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }() 
    
    private lazy var weatherView: WeatherView = {
        let view = WeatherView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    private func setupViews() {
        self.contentView.addSubview(cellHeader)
        self.contentView.addSubview(cellContent)
        self.contentView.backgroundColor = .red
        setupConstraint()
       
    }
    
    private func setupConstraint() {
        labelBottomAnchor = weatherView.bottomAnchor.constraint(equalTo: cellContent.bottomAnchor, constant: -10)
        labelHeightAnchor = weatherView.heightAnchor.constraint(equalToConstant: 50)
        labelBottomAnchor?.priority = .defaultHigh
        labelHeightAnchor?.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            cellHeader.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellHeader.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellHeader.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellHeader.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 60),
            cellHeader.heightAnchor.constraint(equalToConstant: 50),
            
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
        labelBottomAnchor?.isActive = isSelected
        labelHeightAnchor?.isActive = isSelected
    }
    
    func configure(with viewModel: MainCellModel?) {
        titleLabel.text = viewModel?.title
    }
}

//extension MainCollectionCell {
//    private func oneQuestionItem(item: MainCellModel) -> UIView {
//        OneQuestionItem(item: item) { [weak self] answer in
//            guard let self = self else { return }
//            self.selectedAnswer?(answer.title)
//        }
//    }
//}

//final class OneQuestionItem: UIView {
//    var item: MainCellModel
//    var selected: (MainCellModel) -> ()
//    
//    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectAnswer))
//    
//    lazy var contentView: UIView = {
//       let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.addGestureRecognizer(tapGesture)
//        view.backgroundColor = .black
//        return view
//    }()
//    
//    init(frame: CGRect = .zero, item: MainCellModel, selected: @escaping (MainCellModel) -> Void) {
//        self.item = item
//        self.selected = selected
//        
//        super.init(frame: frame)
//        translatesAutoresizingMaskIntoConstraints = false
//        restorationIdentifier = item.title
//        addSubview(contentView)
//        setConstraint()
//    }
//    
//    private func setConstraint() {
//        NSLayoutConstraint.activate([
//            contentView.topAnchor.constraint(equalTo: topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
//        ])
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    @objc
//    private func selectAnswer() {
//        selected(item)
//    }
//}
