//
//  ViewController.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/02/22.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet var beverageCollectionView: UICollectionView!
    @IBOutlet var coinCollectionView: UICollectionView!
  
    var purchasedScrollView: PurChaseScrollView!
    private var vendingMachine: VendingMachine!
    private var beverageCollectionViewDataSource: BeverageCollectionViewDataSource!
    private var coinCollectionViewDataSource: CoinCollectionViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVendingMachine()
        configureCollectionView()
        configureNotification()
//        configurePurchasedScrollView()
    }
    
    private func configureVendingMachine() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        vendingMachine = appDelegate.vendingMachine
    }
    
    func configureCollectionView() {
        beverageCollectionViewDataSource = BeverageCollectionViewDataSource(vendingMachine)
        coinCollectionViewDataSource = CoinCollectionViewDataSource(vendingMachine)
        
        beverageCollectionView.delegate = self
        beverageCollectionView.dataSource = beverageCollectionViewDataSource
        coinCollectionView.delegate = self
        coinCollectionView.dataSource = coinCollectionViewDataSource
    }
    
    func configurePurchasedScrollView() {
        view.addSubview(purchasedScrollView)
        purchasedScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 600).isActive = true
        purchasedScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        addScrollSubView()
    }
    
    func configureNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addBeverage(_:)),
                                               name: VendingMachine.updateStock,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(addCredit(_:)),
                                               name: VendingMachine.updateCredit,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updatePurchased(_:)), name: VendingMachine.updateLog, object: nil)
    }
    
    @objc
    func addBeverage(_ notification: Notification) {
        beverageCollectionView.reloadData()
    }
    
    @objc
    func addCredit(_ notification: Notification) {
        coinCollectionView.reloadData()
    }
    
    @objc
    func updatePurchased(_ notification: Notification) {
        
    }
    
    func addScrollSubView(){
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == self.beverageCollectionView {
            let width:CGFloat = (collectionView.bounds.width - (20 * 4))/3
            let height = collectionView.bounds.height / 2

            return CGSize(width: width, height: height)
        }
        else if collectionView == self.coinCollectionView {
            let width:CGFloat = (collectionView.bounds.width - (20 * 3))/2
            let height = width

            return CGSize(width: width, height: height)
        }
        return CGSize()
    }
}
