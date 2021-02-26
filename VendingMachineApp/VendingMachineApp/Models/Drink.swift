//
//  Drink.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/02/22.
//

import Foundation

class Drink : CustomStringConvertible{
    
    private var brand: String
    private var capacity: Int
    private var price: Int
    private var name: String
    private var manufacturedDate: Date
    private var expiration: Date
    private var hot: Bool
    private var calorie: Int
    
    init(brand: String, capacity: Int, price: Int, name: String, date: Date, expiration: Date, hot: Bool, calorie: Int){
        self.brand = brand
        self.capacity = capacity
        self.price = price
        self.name = name
        self.manufacturedDate = date
        self.expiration = expiration
        self.hot = hot
        self.calorie = calorie
    }
    
    var description: String {
        return "\(brand), \(capacity)ml, \(price)원, \(name), \(manufacturedDate.description)"
    }
    
    func canBuy(with credit: Int) -> Bool {
        return credit > price
    }
    
    func isHot() -> Bool {
        return hot
    }
    
    func isLowCalore() -> Bool {
        return calorie < 300
    }
    
    func validate(date: Date) -> Bool {
        return expiration < date
    }
}
