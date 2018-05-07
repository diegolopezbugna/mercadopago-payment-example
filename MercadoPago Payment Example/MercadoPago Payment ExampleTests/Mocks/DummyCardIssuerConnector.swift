//
//  DummyCardIssuerConnector.swift
//  MercadoPago Payment ExampleTests
//
//  Created by Diego López Bugna on 07/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation

class DummyCardIssuerConnector: CardIssuerConnectorProtocol {
    func getCardIssuers(paymentMethod: PaymentMethod, completion: @escaping ([CardIssuer]?) -> ()) {
        completion([CardIssuer(), CardIssuer()])
    }
}
