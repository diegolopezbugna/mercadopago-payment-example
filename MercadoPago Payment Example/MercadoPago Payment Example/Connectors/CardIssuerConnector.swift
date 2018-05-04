//
//  PaymentMethodConnector.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 30/04/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation

protocol CardIssuerConnectorProtocol {
    func getCardIssuers(paymentMethod: PaymentMethod, completion: @escaping ([CardIssuer]?) -> ())
}

class CardIssuerConnector : CardIssuerConnectorProtocol {
    // TODO: alamoFire?
    
    let getCardIssuersUrl: String = "https://api.mercadopago.com/v1/payment_methods/card_issuers?public_key=%@&payment_method_id=%@"
    let publicKey: String = "444a9ef5-8a6b-429f-abdf-587639155d88" // TODO: move to base/param
    
    func getCardIssuers(paymentMethod: PaymentMethod, completion: @escaping ([CardIssuer]?) -> ()) {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: String(format: getCardIssuersUrl, publicKey, paymentMethod.id ?? ""))!
        NSLog("URL: %@", url.absoluteString)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                NSLog("ERROR: %@", error!.localizedDescription)
                completion(nil)
                return
            }
            guard let data = data else {
                NSLog("DATA NIL")
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            let cardIssuers = try? decoder.decode([CardIssuer].self, from: data)
            
            completion(cardIssuers)
        }
        task.resume()
    }
}

