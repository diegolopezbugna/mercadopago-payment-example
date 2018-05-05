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
    var cardIssuer: CardIssuer?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let amountVC = AmountViewController()
        amountVC.delegate = self
        self.navigationController.pushViewController(amountVC, animated: false)
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
        let cardIssuerVC = CardIssuerViewController(paymentMethod: paymentMethod)
        cardIssuerVC.delegate = self
        self.navigationController.pushViewController(cardIssuerVC, animated: true)
    }
}

extension PayUseCase: CardIssuerViewControllerDelegate {
    func selectedCardIssuer(_ cardIssuer: CardIssuer) {
        self.cardIssuer = cardIssuer
        guard let paymentMethod = self.paymentMethod, let amount = self.amount else { return }
        let installmentVC = InstallmentViewController(paymentMethod: paymentMethod, amount: amount, cardIssuer: cardIssuer)
        installmentVC.delegate = self
        self.navigationController.pushViewController(installmentVC, animated: true)
    }
}

extension PayUseCase: InstallmentViewControllerDelegate {
    func selectedInstallment(_ installment: Installment) {
        self.navigationController.popToRootViewController(animated: true)
        let message = "\(amount != nil ? String(amount!) : "")\n\(paymentMethod?.id ?? "")\n\(cardIssuer?.id ?? "")\n\(installment.recommendedMessage ?? "")"
        self.navigationController.viewControllers[0].showAlert(title: "", message: message, buttonPressed: {})
    }
}
