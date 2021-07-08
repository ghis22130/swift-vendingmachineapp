//
//  PurChaseScrollView.swift
//  VendingMachineApp
//
//  Created by 지북 on 2021/03/17.
//

import UIKit

class PurChaseScrollView: UIScrollView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 200).isActive = true
        widthAnchor.constraint(equalToConstant: 300).isActive = true
    }

}
