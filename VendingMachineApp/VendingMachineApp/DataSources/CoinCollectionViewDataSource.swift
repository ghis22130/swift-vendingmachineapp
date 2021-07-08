//
//  CoinCollectionViewDataSource.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/07/08.
//

import UIKit

final class CoinCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private weak var vendingMachine: VendingMachine?
    
    init(_ vendingMachine: VendingMachine) {
        self.vendingMachine = vendingMachine
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        vendingMachine?.countKindOfCoin() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let vendingMachine = vendingMachine, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoinCollectionCell", for: indexPath) as? CoinCollectionCell else {
            return UICollectionViewCell()
        }
        
        vendingMachine.eachCoin(at: indexPath.item) {
            cell.updateUI(at: $0, at: vendingMachine)
        }
        return cell        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let vendingMachine = vendingMachine else { return UICollectionReusableView() }
        
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CoinCollectionFooterView", for: indexPath) as? CoinCollectionFooterView else {
                return UICollectionReusableView()
            }
            footer.configure(at: vendingMachine.nowCredit().count())
            return footer
        default:
            return UICollectionReusableView()
        }
    }
}
