//
//  VendingMachine.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/02/24.
//

import Foundation

class VendingMachine: NSObject, NSCoding{
    enum Coin: Int, CaseIterable {
        case fifty = 50
        case hundred = 100
        case fivehundred = 500
        case thousand = 1000
        case fifvethousand = 5000
    }
    
    private var stock: BeverageInventory
    private var log: SalesLog
    private var credit: Money
    
    init(beverages: BeverageInventory) {
        self.stock = beverages
        self.credit = Money()
        self.log = SalesLog()
    }
    
    convenience override init() {
        self.init(beverages: BeverageInventory())
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(stock, forKey: "stock")
        coder.encode(credit, forKey: "credit")
        coder.encode(log, forKey: "log")
    }
    
    required init?(coder: NSCoder) {
        self.stock = coder.decodeObject(forKey: "stock") as! BeverageInventory
        self.credit = coder.decodeObject(forKey: "credit") as! Money
        self.log = coder.decodeObject(forKey: "log") as! SalesLog
    }
    
    func show(handler: (Beverage) -> Void) {
        stock.show(handler: handler)
    }
    
    func possibleBeverages() -> [Beverage] {
        return stock.possibleBeverages(with: credit)
    }
    
    func nowCredit() -> Money {
        return credit
    }
    
    func hotBeverages(unit: Double) -> [Beverage] {
        return stock.hotBeverages(unit: unit)
    }
    
    func lowCalorieBeverages(unit: Int) -> [Beverage] {
        return stock.lowCalorieBeverages(unit: unit)
    }
    
    func validateBeverages(when date: Date) -> [Beverage] {
        return stock.validateFromExpired(when: date)
    }
    
    private func canBuy(with beverage: Beverage) -> Bool {
        return credit > beverage.price
    }
    
    private func logUpdate(_ beverage: Beverage) {
        log.update(beverage)
    }
    
    func countType() -> Int {
        return stock.countType()
    }
    
    func countBeverage(at index: Int) -> Int {
        return stock.countBeverage(at: index)
    }
    
    func beverageType(at index: Int) -> Beverage.Type {
        return stock.beverageType(at: index)
    }
    
    func countKindOfCoin() -> Int {
        return Coin.allCases.count
    }
    
    func eachCoin(at index: Int, handler:(Int)-> Void) {
        handler(Coin.allCases[index].rawValue)
    }
}

extension VendingMachine: InsertCoinable {
    func insertCoin(coin: Int) {
        credit.deposit(unit: coin)
    }
}

extension VendingMachine: StockManageAble {
    func append(_ beverage: Beverage) {
        stock.append(beverage)
    }
    
    func append(beverages: [Beverage]) {
        stock.append(beverages)
    }
    
    func purchase(with beverage: Beverage.Type) -> Beverage? {
        if let purchasedBeverage = stock.canPop(beverage){
            credit -= purchasedBeverage.price
            logUpdate(purchasedBeverage)
            return purchasedBeverage
        }
        return nil
    }
}

extension VendingMachine {
    static let updateStock = Notification.Name("updateStock")
    static let updateCredit = Notification.Name("updateCoin")
    static let updateLog = Notification.Name("updateLog")
}
