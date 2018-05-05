//
//  BaseConnector.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 04/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation

class BaseConnector {

    let publicKey: String = "444a9ef5-8a6b-429f-abdf-587639155d88" // TODO: remove hardcoded

    func requestDecodable<T: Decodable>(urlString: String, completion: @escaping (T?) -> ()) {
        // TODO: throws
        // TODO: alamoFire?
        // TODO: Modularizar la llamada para recibir base_url, uri y query_params.

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: urlString)! // TODO: remove !
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
            let decodable = try! decoder.decode(T.self, from: data) // TODO: try? ERRORS!
            print("decoded: ", decodable)
            completion(decodable)
        }
        task.resume()
    }
}
