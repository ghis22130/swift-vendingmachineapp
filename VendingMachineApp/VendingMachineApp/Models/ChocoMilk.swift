//
//  File.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/02/24.
//

import Foundation

class ChocoMilk: Milk {
    
    enum Cacao: String {
        case Original = "Choco Milk"
        case SixtyPercent = "60% Cacaco Choco Milk"
        case NinetyPercent  = "90% Cacaco Choco Milk"
    }
    
    private var cacao: Cacao
    
    init(manufacturedDate: Date, fat: Int, cacao: Cacao, temperature: Double, calorie: Int) {
        self.cacao = cacao
        super.init(brand: "매일우유", capacity: 550, price: Money(how: 2000), name: cacao.rawValue, manufacturedDate: manufacturedDate, fat: fat, expiration: Calendar.current.date(byAdding: .day, value: 14, to: manufacturedDate)!, temperature: temperature, calorie: calorie)
    }
    
    required init() {
        self.cacao = .Original
        let manufacturedDate = Date()
        super.init(brand: "매일우유", capacity: 550, price: Money(how: 2000), name: cacao.rawValue, manufacturedDate: manufacturedDate, fat: 20, expiration: Calendar.current.date(byAdding: .day, value: 14, to: manufacturedDate)!, temperature: 0, calorie: 550)
    }
    
    required init?(coder: NSCoder) {
        self.cacao = Cacao(rawValue: coder.decodeObject(forKey: "cacao") as! String)!
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(cacao.rawValue, forKey: "cacao")
        super.encode(with: coder)
    }
    
}
