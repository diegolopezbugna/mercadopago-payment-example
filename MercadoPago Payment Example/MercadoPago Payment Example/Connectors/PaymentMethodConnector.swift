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

class PaymentMethodConnector : PaymentMethodConnectorProtocol {
    // TODO: alamoFire?
    
    let getPaymentMethodsUrl: String = "https://api.mercadopago.com/v1/payment_methods?public_key=%@"
    let publicKey: String = "444a9ef5-8a6b-429f-abdf-587639155d88" // TODO: move to base/param
    
    func getPaymentMethods(completion: @escaping ([PaymentMethod]?) -> ()) {
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: String(format: getPaymentMethodsUrl, publicKey))!
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
            let paymentMethods = try? decoder.decode([PaymentMethod].self, from: data)
            
            completion(paymentMethods)
        }
        task.resume()
    }
}

