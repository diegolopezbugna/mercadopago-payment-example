//
//  PaymentMethod.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 30/04/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation

class PaymentMethod : Codable, CustomStringConvertible {
    
    var id: String?
    var thumbnail: String?
    var thumbnailData: Data?
    var name: String?
    
    var description: String { return "{ PaymentMethod: id:\(id ?? "") }" }
    
}
