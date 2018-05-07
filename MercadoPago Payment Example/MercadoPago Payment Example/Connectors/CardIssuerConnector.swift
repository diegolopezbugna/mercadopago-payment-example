//
//  CardIssuerConnector.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 30/04/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation

protocol CardIssuerConnectorProtocol {
    func getCardIssuers(paymentMethod: PaymentMethod, completion: @escaping ([CardIssuer]?) -> ())
}

class CardIssuerConnector : BaseConnector, CardIssuerConnectorProtocol {
    
    func getCardIssuers(paymentMethod: PaymentMethod, completion: @escaping ([CardIssuer]?) -> ()) {
        let uri = "payment_methods/card_issuers"
        let queryItems = [URLQueryItem(name: "payment_method_id", value: paymentMethod.id)]
        self.requestDecodable(uri: uri, queryItems: queryItems, completion: completion)
    }
}

