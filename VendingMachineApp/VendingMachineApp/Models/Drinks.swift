//
//  Drinks.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/02/25.
//

import Foundation

class Drinks {
    
    private var drinks: [Drink]
    private var dictionry: DrinksDictionary
    
    init() {
        self.drinks = []
        self.dictionry = DrinksDictionary()
    }
    
    init(_ drinks: [Drink]) {
        self.drinks = drinks
        self.dictionry = DrinksDictionary()
        classify(with: drinks)
    }
    
    func show(handler: (Drink) -> Void) {
        drinks.forEach {
            handler($0)
        }
    }
    
    func append(_ drink: Drink) {
        drinks.append(drink)
        classify(with: drink)
    }
    
    func append(_ newDrinks: [Drink]) {
        newDrinks.forEach {
            drinks.append($0)
        }
        classify(with: drinks)
    }
    
    func possibleDrinks(with credit: Int) -> Drinks {
        return Drinks(drinks.filter {
            $0.canBuy(with: credit)
        })
    }
    
    func validateDrinks(when date: Date) -> Drinks {
        return Drinks(drinks.filter {
            $0.validate(date: date)
        })
    }
    
    func hotDrinks() -> Drinks {
        return Drinks(drinks.filter {
            $0.isHot()
        })
    }
    
    func lowCalorieDrinks() -> Drinks {
        return Drinks(drinks.filter {
            $0.isLowCalore()
        })
    }
    
    func classify(with drink: Drink) {
        dictionry.append(drink)
    }
    
    func classify(with drinks: [Drink]){
        drinks.forEach {
            dictionry.append($0)
        }
    }
    
    //음료를 하나하나 출력하는 show 메소드가 불필요해지면 show로 바꿀 예정
    func showStock() -> Dictionary<Drink, Int>{
        return dictionry.drinkDictionary
    }
}
