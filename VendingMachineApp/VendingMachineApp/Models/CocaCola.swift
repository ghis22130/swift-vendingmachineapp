//
//  Cola.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/02/24.
//

import Foundation

class CocaCola: Soda {
    enum Flavor: String{
        case Original = "Original Cola"
        case Cherry = "Cherry Cola"
        case Vanilla = "Vanilla Cola"
    }
    
    private var flavor: Flavor
    
    init(manufacturedDate: Date, isZero: Bool, flavor: Flavor, temperature: Double, calorie: Int) {
        self.flavor = flavor
        super.init(brand: "코카콜라", capacity: 333, price: Money(how: 2200), name: flavor.rawValue, manufacturedDate: Date(), expiration: Calendar.current.date(byAdding: .day, value: 90, to: manufacturedDate)!, temperature: temperature, calorie: calorie)
    }
    
    required init() {
        self.flavor = .Original
        let manufacturedDate = Date()
        super.init(brand: "코카콜라", capacity: 333, price: Money(how: 2200), name: flavor.rawValue, manufacturedDate: Date(), expiration: Calendar.current.date(byAdding: .day, value: 90, to: manufacturedDate)!, temperature: 0, calorie: 385)
    }
    
    required init?(coder: NSCoder) {
        self.flavor = Flavor(rawValue: coder.decodeObject(forKey: "colaFlavor") as! String)!
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(flavor.rawValue, forKey: "colaFlavor")
        super.encode(with: coder)
    }
}
