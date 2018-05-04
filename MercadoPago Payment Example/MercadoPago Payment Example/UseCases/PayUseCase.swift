//
//  PayUseCase.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 02/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation
import UIKit // TODO: remove UIKit and add a Navigator and Presenters

class PayUseCase {

    let navigationController: UINavigationController
    
    var amount: Int?
    var paymentMethod: PaymentMethod?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let amountVC = AmountViewController()
        amountVC.delegate = self
        self.navigationController.pushViewController(amountVC, animated: false)
    }
    
    func didSelectPaymentMethod(_ paymentMethod: PaymentMethod) {
        self.paymentMethod = paymentMethod
        
    }
    
}

extension PayUseCase: AmountViewControllerDelegate {
    func continueButtonPressed(amount: Int?) {
        // TODO: validations
        self.amount = amount
        let paymentMethodVC = PaymentMethodViewController(amount: amount)
        paymentMethodVC.delegate = self
        self.navigationController.pushViewController(paymentMethodVC, animated: true)
    }
}

extension PayUseCase: PaymentMethodViewControllerDelegate {
    func selectedPaymentMethod(_ paymentMethod: PaymentMethod) {
        self.paymentMethod = paymentMethod
        
    }
}