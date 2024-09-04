//
//  CollectionViewAdapter.swift
//  MiniApp
//
//  Created by Danil Komarov on 03.09.2024.
//

import UIKit

final class CollectionViewAdapter: NSObject {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, MainCellModel>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, MainCellModel>
    
    private weak var collectionView: UICollectionView?
    private var cellDataSource: [MainCellModel] = []
    private var dataSource: DataSource?
    private var snapshot = DataSourceSnapshot()
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView?.backgroundColor = .blue
        self.collectionView?.delegate = self
        registerCell()
    }
    
    private func registerCell() {
        self.collectionView?.register(MainCollectionCell.self, forCellWithReuseIdentifier: MainCollectionCell.identifire)
        self.collectionView?.register(WeatherCollectionCell.self, forCellWithReuseIdentifier: WeatherCollectionCell.identifire)
    }
    
    private func applySnapshot(data: [MainCellModel]) {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([Section.main])
        snapshot.appendItems(data)
    
        
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func reload(_ data: [MainCellModel]?) {
        guard let data = data else { return }
        cellDataSource = data
        configureCollectionViewDataSource()
        applySnapshot(data: data)
        
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CollectionViewAdapter {
    private func configureCollectionViewDataSource() {
        dataSource = DataSource(collectionView: collectionView!, cellProvider: { (collectionView, indexPath, itemIdentifier) in
            let vehicle = self.cellDataSource[indexPath.row]
            switch vehicle.type {
            case .mainTemp:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCell.identifire, for: indexPath) as? MainCollectionCell
                cell?.configure(with: vehicle)
                return cell ?? MainCollectionCell()
            case .weatherCell:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionCell.identifire, for: indexPath) as? WeatherCollectionCell
                cell?.configure(with: vehicle)
                return cell ?? MainCollectionCell()
            case .none:
                return MainCollectionCell()
            }
        })
    }
}

// MARK: - UICollectionViewDelegate

extension CollectionViewAdapter: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width-32, height: collectionView.bounds.height / 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
}

