//
//  CoinCollectionCell.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/03/10.
//

import UIKit

class CoinCollectionCell: UICollectionViewCell {
    @IBOutlet var coinButton: UIButton!
    var coin: Money?
    var coinDelegate: InsertCoinable?
    
    func updateUI(at coin: Int, at delegate: InsertCoinable) {
        let title = String(coin) + "원"
        self.coin = Money(how: coin)
        coinButton.setTitle(title, for: .normal)
        coinButton.addTarget(self, action: #selector(onTapButton), for: .touchUpInside)
        self.coinDelegate = delegate
    }
    
    @objc
    func onTapButton() {
        coinDelegate?.insertCoin(coin: (coin?.count())!)
    }
}
