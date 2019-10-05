//
//  VendingMachine.swift
//  VendingMachine
//
//  Created by 이동영 on 16/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

typealias State = (balance: Money, inventory: Storable, history: History)

protocol VendingMachinePresenterType: MoneyHandleable {
    var numOfRow: Int { get }
    func cellForItemAt(index: Int) -> ProductStatistic
    mutating func setStrategy(_ strategy: StateHandleable?)
    func searchItem(at index: Int) -> Beverage?
    mutating func execute() throws
}

class VendingMachinePresenter: NSObject, NSCoding {
    var isOnSale: Bool {
        return !inventory.filter(by: .all).isEmpty
    }
    private var balance: Money
    private var inventory: Storable
    private var history: History
    private var strategy: StateHandleable?
    
    init(balance: Money,
         inventory: Storable,
         history: History) {
        self.balance = balance
        self.inventory = inventory
        self.history = history
    }
    
    required convenience init?(coder: NSCoder) {
        let balance = coder.decodeObject(forKey: Keys.balance.rawValue) as! Money
        let inventory = coder.decodeObject(forKey: Keys.inventory.rawValue) as! Inventory
        let history = coder.decodeObject(forKey: Keys.history.rawValue) as! History
        
        self.init(balance: balance,
                  inventory: inventory,
                  history: history)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(balance, forKey: Keys.balance.rawValue)
        coder.encode(inventory, forKey: Keys.inventory.rawValue)
        coder.encode(history, forKey: Keys.history.rawValue)
    }
    
    func searchItem(at index: Int) -> Beverage? {
        return inventory.search(at: index)
    }
    
    func setStrategy(_ strategy: StateHandleable?) {
        self.strategy = strategy
    }
    
    func execute() throws {
        let state = (balance: balance, inventory: inventory, history: history)
        
        guard
            let result = strategy?.handle(state)
            else { return }
        try resultHandle(result)
    }
    
    func handleStrategy(_ handler: (StateHandleable) -> Void) {
        guard
            let strategy = strategy
            else { return }
        handler(strategy)
    }
    
    func resultHandle(_ result: Result<State, Error>) throws {
        switch result {
        case .success(let newState):
            (self.balance, self.inventory, self.history) = newState
            self.strategy?.complete()
        case .failure(let error):
            throw error
        }
    }
    
}
// MARK: - + MoneyHandleable
extension VendingMachinePresenter: MoneyHandleable {
    
    func handleMoney(_ handler: (Money) -> Void) {
        handler(balance)
    }
    
}
// MARK: - + MoneyHandleable
extension VendingMachinePresenter: ProductStatisticHandleable {
    
    func handleProductStatistic(_ handler: ([ProductStatistic]) -> Void) {
        handler(inventory.statistic)
    }
}
extension VendingMachinePresenter: VendingMachinePresenterType {
    
    var numOfRow: Int {
        return inventory.statistic.count
    }
    
    func cellForItemAt(index: Int) -> ProductStatistic {
        return inventory.statistic[index]
    }
    
}
// MARK: Keys
extension VendingMachinePresenter {
    enum Keys: String {
        case balance = "Balance"
        case inventory = "Inventory"
        case history = "History"
    }
}