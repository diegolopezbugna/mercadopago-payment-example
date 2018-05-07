//
//  PaymentMethodConnector.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 30/04/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation

protocol PaymentMethodConnectorProtocol {
    func getPaymentMethods(completion: @escaping ([PaymentMethod]?) -> ())
}

class PaymentMethodConnector : BaseConnector, PaymentMethodConnectorProtocol {
    
    func getPaymentMethods(completion: @escaping ([PaymentMethod]?) -> ()) {
        let uri = "payment_methods"
        self.requestDecodable(uri: uri, completion: completion)
    }
    
}

