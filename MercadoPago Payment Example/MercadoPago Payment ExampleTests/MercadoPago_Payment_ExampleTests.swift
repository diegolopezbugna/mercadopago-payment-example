//
//  MercadoPago_Payment_ExampleTests.swift
//  MercadoPago Payment ExampleTests
//
//  Created by Diego López Bugna on 28/04/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import XCTest
@testable import MercadoPago_Payment_Example

class MercadoPago_Payment_ExampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBaseConnectorSettings() {
        let connector = BaseConnector()
        XCTAssert(connector.baseUrl!.absoluteString == "https://api.mercadopago.com/v1/")
        XCTAssert(connector.publicKey == "444a9ef5-8a6b-429f-abdf-587639155d88")
    }
    
    // NOTA IMPORTANTE:
    // PayUseCase debería comunicarse con protocolos en vez de los ViewControllers
    //  y el Navigator para poder testearlo.
    // Lo interesante de estos tests sería testear PayUseCase.
    // Falta mejorar ese aspecto.

}
