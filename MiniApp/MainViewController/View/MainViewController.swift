//
//  ViewController.swift
//  MiniApp
//
//  Created by Danil Komarov on 03.09.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    var viewModel: MainViewModel?
    
    private lazy var adapter = CollectionViewAdapter(collectionView: mainCollectionView)
    private lazy var mainCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 20
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collection = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.allowsMultipleSelection = true
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "FFA000")
        addViews()
        setupConstraint()
        bindViewModel()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        mainCollectionView.collectionViewLayout.invalidateLayout()  // Пересчитываем макет коллекции при изменении ориентации
    }
    
    private func addViews() {
        view.addSubview(mainCollectionView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func bindViewModel() {
        viewModel?.dataRelaod()
        
        viewModel?.onDataReload = { [weak self] result in
            self?.adapter.reload(result)
        }
        
        adapter.onFullScreen = { [weak self] data in
            guard let data = data else { return }
            self?.viewModel?.showFullScreenVC(data: data)
        }
        
    }
}

