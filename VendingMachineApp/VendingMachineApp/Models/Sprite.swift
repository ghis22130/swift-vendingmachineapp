//
//  Sprite.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/02/24.
//

import Foundation

class Sprite: Soda {
    enum Flavor: String {
        case Original = "Original Sprite"
        case Ginger = "Ginger Sprite"
        case Tropical = "Tropical Sprite"
    }
    
    private var flavor: Flavor
    
    init(date: Date, isZero: Bool, flavor: Flavor, temperature: Double, calorie: Int) {
        self.flavor = flavor
        super.init(brand: "스프라이트", capacity: 333, price: Money(how: 1800), name: flavor.rawValue, manufacturedDate: date,expiration: Calendar.current.date(byAdding: .day, value: 90, to: date)!, temperature: temperature, calorie: calorie)
    }
    
    required init() {
        self.flavor = .Original
        let manufacturedDate = Date()
        super.init(brand: "스프라이트", capacity: 333, price: Money(how: 1800), name: flavor.rawValue, manufacturedDate: manufacturedDate,expiration: Calendar.current.date(byAdding: .day, value: 90, to: manufacturedDate)!, temperature: 0, calorie: 385)
    }
    
    required init?(coder: NSCoder) {
        self.flavor = Flavor(rawValue: coder.decodeObject(forKey: "spriteFlavor") as! String)!
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(flavor.rawValue, forKey: "spriteFlavor")
        super.encode(with: coder)
    }
}
