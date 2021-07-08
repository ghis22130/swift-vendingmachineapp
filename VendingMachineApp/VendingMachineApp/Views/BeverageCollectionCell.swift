//
//  DrinkCollectionCell.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/03/09.
//

import UIKit

class BeverageCollectionCell: UICollectionViewCell {
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet var beverageImage: UIImageView!
    @IBOutlet var stockNumber: UILabel!
    @IBOutlet var purchasedButton: UIButton!
    
    var beverageType: (()->Beverage.Type)?
    var count: Int?
    var stockDelegate: StockManageAble?
    
    func updateUI(beverageType: String, count: Int, at delegate: StockManageAble) {
        self.count = count
        addButton.setTitle("추가", for: .normal)
        addButton.addTarget(self, action: #selector(onTapAddButton), for: .touchUpInside)
        purchasedButton.setTitle("구매", for: .normal)
        purchasedButton.addTarget(self, action: #selector(onTapPurchasedButton), for: .touchUpInside)
        stockNumber.text = String(count) + "개"
        beverageImage.image = UIImage(named: "\(beverageType).jepg") ?? UIImage()
        self.stockDelegate = delegate
    }
    
    @objc
    func onTapAddButton() {
        guard let type = beverageType?() else {
            return
        }
        stockDelegate?.append(BeverageFactory.create(type: type) ?? Beverage())
    }
    
    @objc
    func onTapPurchasedButton() {
        guard let type = beverageType?() else {
            return
        }
        _ = stockDelegate?.purchase(with: type)
    }
}
