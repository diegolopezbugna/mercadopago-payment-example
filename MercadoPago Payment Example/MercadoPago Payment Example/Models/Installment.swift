//
//  Installment.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 04/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation

class Installment: Codable, CustomStringConvertible {
    
    var recommendedMessage: String?
    
    init(recommendedMessage: String?) {
        self.recommendedMessage = recommendedMessage
    }
    
    var description: String { return "{ Installment: \(recommendedMessage ?? "") }" }
    
}
