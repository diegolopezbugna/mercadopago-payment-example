//
//  DummyInstallmentConnector.swift
//  MercadoPago Payment ExampleTests
//
//  Created by Diego López Bugna on 07/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation

class DummyInstallmentConnector: InstallmentConnectorProtocol {
    func getInstallments(paymentMethod: PaymentMethod, amount: Int, cardIssuer: CardIssuer, completion: @escaping ([Installment]?) -> ()) {
        completion([Installment(recommendedMessage: "6 cuotas"),
                    Installment(recommendedMessage: "12 cuotas")])
    }
}
