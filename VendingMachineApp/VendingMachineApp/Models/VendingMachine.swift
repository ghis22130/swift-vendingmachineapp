//
//  VendingMachine.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/02/24.
//

import Foundation

class VendingMachine {
    enum Coin: Int {
        case fifty = 50
        case hundred = 100
        case fivehundred = 500
        case thousand = 1000
        case fifvethousand = 5000
    }
    
    private var stock: Drinks
    private var credit: Int
    private var log: SalesLog

    init(drinks: Drinks) {
        self.stock = drinks
        self.credit = 0
        self.log = SalesLog()
    }
    
    convenience init() {
        self.init(drinks: Drinks())
    }
    
    func show(handler: (Drink) -> Void) {
        stock.show(handler: handler)
    }
    
    func insertCoin(coin: Coin) {
        credit += coin.rawValue
    }
    
    func append(_ drink: Drink) {
        stock.append(drink)
    }
    
    func append(drinks: [Drink]) {
        stock.append(drinks)
    }
    
    func possibleDrinks() -> Drinks {
        return stock.possibleDrinks(with: credit)
    }
    
    func nowCredit() -> Int {
        return credit
    }
    
    func hotDrinks() -> Drinks {
        return stock.hotDrinks()
    }
    
    func lowCalorieDrinks() -> Drinks {
        return stock.lowCalorieDrinks()
    }
    
    func validateDrinks(when date: Date) -> Drinks {
        return stock.validateDrinks(when: date)
    }
    
    func canBuy(with drink: Drink) -> Bool {
        return credit > drink.price
    }
    
    func buy(with drink: Drink) -> Drink {
        if !hasDrink(with: drink) || canBuy(with: drink){
            return Drink()
        }
        credit -= drink.price
        update(with: drink)
        return drink
    }
    
    func hasDrink(with drink: Drink) -> Bool {
        return stock.hasDrink(with: drink)
    }
    
    func update(with drink: Drink) {
        logUpdate(drink)
        dictionaryUpdate(drink)
    }
    
    func dictionaryUpdate(_ drink: Drink) {
        stock.diconaryUpdate(with: drink)
    }
    
    func logUpdate(_ drink: Drink) {
        log.update(drink)
    }
}
