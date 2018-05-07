//
//  InstallmentConnectorProtocol.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 30/04/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation

protocol InstallmentConnectorProtocol {
    func getInstallments(paymentMethod: PaymentMethod,
                         amount: Int,
                         cardIssuer: CardIssuer,
                         completion: @escaping ([Installment]?) -> ())
}

class InstallmentConnector : BaseConnector, InstallmentConnectorProtocol {
    
    func getInstallments(paymentMethod: PaymentMethod,
                        amount: Int,
                        cardIssuer: CardIssuer,
                        completion: @escaping ([Installment]?) -> ()) {
        
        let uri = "payment_methods/installments"
        let queryItems = [URLQueryItem(name: "payment_method_id", value: paymentMethod.id),
                          URLQueryItem(name: "amount", value: String(amount)),
                          URLQueryItem(name: "issuer.id", value: cardIssuer.id)]
        
        let apiCompletion = { (apiInstallments: [ApiInstallment]?) -> () in
            let installments = apiInstallments?[0].payer_costs?.map({ (apiPayerCost) -> Installment in
                return Installment(recommendedMessage: apiPayerCost.recommended_message)
            })
            completion(installments)
        }
        self.requestDecodable(uri: uri, queryItems: queryItems, completion: apiCompletion)
    }
}

struct ApiInstallment: Codable {
    var payer_costs: [ApiPayerCost]?
}

struct ApiPayerCost: Codable {
    var recommended_message: String?
}
