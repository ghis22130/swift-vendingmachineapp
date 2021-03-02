//
//  TestScenario.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/03/02.
//

import Foundation

struct TestScenario: Testable {
    private var vendingMachine: VendingMachine
    
    init(_ vendingMachine: VendingMachine) {
        self.vendingMachine = vendingMachine
    }
    
    func run() {
        inputDrink()
        동전입력후가능한음료출력(coin: .fifty)
        동전입력후가능한음료출력(coin: .fifvethousand)
        따듯한음료만출력()
        현재금액과음료구매_음료출력_남은금액출력()
        상품구매이력출력()
    }
    
    func inputDrink() {
        let drinks: [Drink] = [
            StrawberryMilk(date: Date().date("20210220"), lowFat: false, container: .bottle, expiration: Date().date("20210310"), hot: false, calorie: 250),
                                CocaCola(date: Date().date("20180220"), isZero: true, flavor: .Original, expiration: Date().date("20210228"), hot: false, calorie: 0),
            Top(date: Date().date("20190317"), decaffein: false, flavor: .Black, expiration: Date().date("20210101"), hot: true, calorie: 100),
            Cantata(date: Date().date("20201003"), decaffein: true, flavor: .KaramelMacchiato, expiration: Date().date("20210707"), hot: true, calorie: 100),
            ChocoMilk(date: Date().date("20210101"), lowFat: true, cacao: .NinetyPercent, expiration: Date().date("20210304"), hot: false, calorie: 150),
            Sprite(date: Date().date("20210202"), isZero: false, flavor: .Ginger, expiration: Date().date("20210608"), hot: false, calorie: 500)
        ]
        
        vendingMachine.append(drinks: drinks)
    }
    
    func 동전입력후가능한음료출력(coin: VendingMachine.Coin) {
        print("\n======Possibe Drinks!======")
        vendingMachine.insertCoin(coin: coin)
        vendingMachine.possibleDrinks().show {
            print($0)
        }
    }
    
    func 따듯한음료만출력() {
        print("\n======Hot Drinks!======")
        vendingMachine.hotDrinks().show {
            print($0)
        }
    }
    
    func 현재금액과음료구매_음료출력_남은금액출력() {
        print("\n====Now Your Credit====")
        print(vendingMachine.nowCredit())
        print("\n======Buy======")
        print(vendingMachine.buy(with: StrawberryMilk(date: Date().date("20210220"), lowFat: false, container: .bottle, expiration: Date().date("20210310"), hot: false, calorie: 250)))
        print("\n====Now Your Credit====")
        print(vendingMachine.nowCredit())
    }
    
    func 상품구매이력출력() {
        print("\n====Sales Log=====")
        vendingMachine.showLog().forEach {
            print($0)
        }
    }
}