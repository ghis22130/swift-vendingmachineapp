//
//  DrinkList.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/02/26.
//

import Foundation

class BeverageInventory: NSObject, NSCoding {
     
     private var allTypes: [Beverage.Type] = [StrawberryMilk.self, ChocoMilk.self, Sprite.self, CocaCola.self, Top.self, Cantata.self]
     private (set) var beverages: [Beverage]
     
     override init(){
          self.beverages = []
          super.init()
     }
     
     func encode(with coder: NSCoder) {
          coder.encode(beverages, forKey: "beverages")
     }
     
     required init?(coder: NSCoder) {
          self.beverages = coder.decodeObject(forKey: "beverages") as! [Beverage]
     }
     
     func append(_ beverage: Beverage) {
          beverages.append(beverage)
     }
     
     func append(_ beverages: [Beverage]) {
          beverages.forEach {
               self.beverages.append($0)
          }
     }
     
     func show(handler: (Beverage) -> Void) {
          beverages.forEach {
               handler($0)
          }
     }
     
     func canPop(_ beverage: Beverage) -> Bool {
          if let index = beverages.firstIndex(where: {ObjectIdentifier(type(of: $0)) == ObjectIdentifier(beverage)}) {
               beverages.remove(at: index)
               return true
          }
          return false
     }
     
     func count() -> Int {
          beverages.count
     }
     
     func countType() -> Int {
          return allTypes.count
     }
     
     func beverageType(at index: Int) -> Beverage.Type {
          return allTypes[index]
     }
     
     func countBeverage(at index: Int) -> Int {
          var count = 0
          beverages.forEach {
               if ObjectIdentifier(type(of: $0)) == ObjectIdentifier(allTypes[index]) {
                    count += 1
               }
          }
          return count
     }
     
     func allBeverages() -> Dictionary<ObjectIdentifier, [Beverage]> {
          var inventory: Dictionary<ObjectIdentifier, [Beverage]> = [:]
          inventory = beverages.reduce(into: [:]) { dict, beverage in
               let objectIdentifier = ObjectIdentifier(type(of: beverage))
               dict[objectIdentifier, default: []].append(beverage)
          }
          return inventory
     }
     
     func possibleBeverages(with credit: Money) -> [Beverage]{
          var possibleBeverages:[Beverage] = []
          possibleBeverages = beverages.filter {
               $0.canBuy(with: credit)
          }
          return possibleBeverages
     }
     
     func hotBeverages(unit: Double) -> [Beverage] {
          var hotBeverages: [Beverage] = []
          hotBeverages = beverages.filter {
               $0.isHot(unit: unit)
          }
          return hotBeverages
     }
     
     func lowCalorieBeverages(unit: Int) -> [Beverage] {
          var lowCalorieBeverages: [Beverage] = []
          lowCalorieBeverages = beverages.filter {
               $0.isLowCalore(unit: unit)
          }
          return lowCalorieBeverages
     }
     
     func validateFromExpired(when date: Date) -> [Beverage] {
          var validateBeverages: [Beverage] = []
          validateBeverages = beverages.filter {
               $0.validateFromExpired(date: date)
          }
          return validateBeverages
     }
}
