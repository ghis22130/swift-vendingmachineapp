//
//  StockManageAble.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/03/17.
//

import Foundation

protocol StockManageAble {
    func purchase(with beverage: Beverage.Type) -> Beverage?
    
    func append(_ beverage: Beverage)
    
    func append(beverages: [Beverage])
    
}
