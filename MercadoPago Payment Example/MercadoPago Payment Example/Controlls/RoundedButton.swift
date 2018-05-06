//
//  RoundedButton.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 06/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.backgroundColor = AppDelegate.mercadoPagoPrimaryColor
        self.tintColor = UIColor.white
    }
    
}
