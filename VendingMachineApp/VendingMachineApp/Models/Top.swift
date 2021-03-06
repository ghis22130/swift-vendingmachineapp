//
//  TOP.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/02/24.
//

import Foundation

class Top: Coffee {
    enum Flavor: String {
        case Black = "The Black"
        case SweetAmericano = "Sweet Americano"
        case Latte = "Maset Latte"
    }
    
    private var flavor: Flavor
    
    init(manufacturedDate: Date, caffein: Int, flavor: Flavor, temperature: Double, calorie: Int) {
        self.flavor = flavor
        super.init(brand: "TOP", capacity: 275, price: Money(how: 1800), name: flavor.rawValue, manufacturedDate: manufacturedDate, caffein: caffein, expiration: Calendar.current.date(byAdding: .day, value: 60, to: manufacturedDate)!, temperatue: temperature, calorie: calorie)
    }
    
    required init() {
        self.flavor = .SweetAmericano
        let manufacturedDate = Date()
        super.init(brand: "TOP", capacity: 275, price: Money(how: 1800), name: flavor.rawValue, manufacturedDate: manufacturedDate, caffein: 20, expiration: Calendar.current.date(byAdding: .day, value: 60, to: manufacturedDate)!, temperatue: 40, calorie: 20)
    }
    
    required init?(coder: NSCoder) {
        self.flavor = Flavor(rawValue: coder.decodeObject(forKey: "topFlavor") as! String)!
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(flavor.rawValue, forKey: "topFlavor")
        super.encode(with: coder)
    }
}
