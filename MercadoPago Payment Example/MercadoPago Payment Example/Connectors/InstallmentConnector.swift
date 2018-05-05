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
    
    let getInstallmentsUrl: String = "https://api.mercadopago.com/v1/payment_methods/installments?public_key=%@&payment_method_id=%@&amount=%@&issuer.id=%@"
    
    func getInstallments(paymentMethod: PaymentMethod,
                        amount: Int,
                        cardIssuer: CardIssuer,
                        completion: @escaping ([Installment]?) -> ()) {
        
        let urlString = String(format: getInstallmentsUrl, self.publicKey,
                               paymentMethod.id ?? "", String(amount), cardIssuer.id ?? "")
        
        let apiCompletion = { (apiInstallments: [ApiInstallment]?) -> () in
            let installments = apiInstallments?[0].payer_costs?.map({ (apiPayerCost) -> Installment in
                return Installment(recommendedMessage: apiPayerCost.recommended_message)
            })
            completion(installments)
        }
        self.requestDecodable(urlString: urlString, completion: apiCompletion)
    }
}

struct ApiInstallment: Codable {
    var payer_costs: [ApiPayerCost]?
}

struct ApiPayerCost: Codable {
    var recommended_message: String?
}
