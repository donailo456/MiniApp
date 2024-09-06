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
    private let sizingCell = MainCollectionCell()
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView?.backgroundColor = .white
        self.collectionView?.delegate = self
        registerCell()
    }
    
    private func registerCell() {
        self.collectionView?.register(MainCollectionCell.self, forCellWithReuseIdentifier: MainCollectionCell.identifire)
        self.collectionView?.register(WeatherCollectionCell.self, forCellWithReuseIdentifier: WeatherCollectionCell.identifire)
        self.collectionView?.register(TicTacToeCollectionCell.self, forCellWithReuseIdentifier: TicTacToeCollectionCell.identifire)
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
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionCell.identifire, for: indexPath) as? MainCollectionCell else { return UICollectionViewCell() }
                cell.configure(with: vehicle)
//                cell.selectedAnswer = { [weak self] _ in
//
//                }
                return cell
            case .weatherCell:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionCell.identifire, for: indexPath) as? WeatherCollectionCell else { return UICollectionViewCell() }
                cell.configure(with: vehicle)
                return cell 
            case .ticTacToe:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicTacToeCollectionCell.identifire, for: indexPath) as? TicTacToeCollectionCell else { return UICollectionViewCell() }
                cell.configure(with: vehicle)
                return cell
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
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: collectionView.bounds.width-32, height: collectionView.bounds.height / 8)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        5
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sizingCell.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: collectionView.bounds.height / 8), withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        collectionView.performBatchUpdates(nil)
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.performBatchUpdates(nil)
        return true
    }
    
}

