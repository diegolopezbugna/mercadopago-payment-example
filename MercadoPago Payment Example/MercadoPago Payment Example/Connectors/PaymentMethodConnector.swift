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
    
    let getPaymentMethodsUrl: String = "https://api.mercadopago.com/v1/payment_methods?public_key=%@"
    
    func getPaymentMethods(completion: @escaping ([PaymentMethod]?) -> ()) {
        let urlString = String(format: getPaymentMethodsUrl, self.publicKey)
        self.requestDecodable(urlString: urlString, completion: completion)
    }
    
}

