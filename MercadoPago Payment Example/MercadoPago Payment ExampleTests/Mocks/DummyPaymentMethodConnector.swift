//
//  DummyPaymentMethodConnector.swift
//  MercadoPago Payment ExampleTests
//
//  Created by Diego López Bugna on 07/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation

class DummyPaymentMethodConnector: PaymentMethodConnectorProtocol {
    func getPaymentMethods(completion: @escaping ([PaymentMethod]?) -> ()) {
        completion([PaymentMethod(), PaymentMethod()])
    }
}
