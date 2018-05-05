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
    
    let getCardIssuersUrl: String = "https://api.mercadopago.com/v1/payment_methods/card_issuers?public_key=%@&payment_method_id=%@"
    
    func getCardIssuers(paymentMethod: PaymentMethod, completion: @escaping ([CardIssuer]?) -> ()) {
        let urlString = String(format: getCardIssuersUrl, self.publicKey, paymentMethod.id ?? "")
        self.requestDecodable(urlString: urlString, completion: completion)
    }
}

