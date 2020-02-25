//
//  VendingMachine.swift
//  VendingMachineApp
//
//  Created by Cory Kim on 2020/02/20.
//  Copyright © 2020 corykim0829. All rights reserved.
//

import Foundation

struct VendingMachine {
    let stock: Stock = Stock()
    let products: Set<Beverage>
    private var purchased: [Beverage] = []
    private(set) var balance: Money = Money()
    
    init(products: [Beverage]) {
        self.products = Set(products)
    }
    
    mutating func putMoney(_ money: Money) {
        balance.add(money: money)
    }
    
    func addToStock(beverage: Beverage) {
        stock.enqueue(beverage: beverage)
    }
    
    func numberOfBeverage(_ beverage: Beverage) -> Int {
        return stock.numberOf(beverage)
    }
    
    func availableBeverages() -> Set<Beverage> {
        var availableBeverages: Set<Beverage> = []
        products.forEach { (product) in
            guard balance > product.price else { return }
            availableBeverages.insert(product)
        }
        return availableBeverages
    }
    
    mutating func select(_ beverage: Beverage) {
        guard balance >= beverage.price && stock.numberOf(beverage) > 0 else { return }
        balance.subtract(money: beverage.price)
        stock.dequeue(beverage: beverage)
        purchased.append(beverage)
    }
}