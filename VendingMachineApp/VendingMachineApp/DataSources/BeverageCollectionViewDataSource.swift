//
//  BeverageCollectionViewDataSource.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/07/08.
//

import UIKit

final class BeverageCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private weak var vendingMachine: VendingMachine?
    
    init(_ vendingMachine: VendingMachine) {
        self.vendingMachine = vendingMachine
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vendingMachine?.countType() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let vendingMachine = vendingMachine else { return UICollectionViewCell() }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeverageCollectionCell", for: indexPath) as? BeverageCollectionCell else {
            return UICollectionViewCell()
        }
        
        let beverageType = vendingMachine.beverageType(at: indexPath.item)
        let beverageCount = vendingMachine.countBeverage(at: indexPath.item)
        
        cell.updateUI(beverageType: String(describing: beverageType), count: beverageCount, at: vendingMachine)
        cell.beverageType = { () in
            return beverageType
        }
        return cell
    }
}
