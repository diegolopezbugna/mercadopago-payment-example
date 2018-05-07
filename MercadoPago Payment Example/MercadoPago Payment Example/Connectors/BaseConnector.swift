//
//  BaseConnector.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 04/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation

class BaseConnector {

    let publicKey = "444a9ef5-8a6b-429f-abdf-587639155d88" // TODO: remove hardcoded

    func requestDecodable<T: Decodable>(urlString: String, completion: @escaping (T?) -> ()) {
        // TODO: Modularizar la llamada para recibir base_url, uri y query_params.

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        guard let url = URL(string: urlString) else {
            NSLog("ERROR: can't form url from \(urlString)")
            completion(nil)
            return
        }
        NSLog("URL: \(url)")

        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                NSLog("ERROR: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                NSLog("DATA NIL")
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let decodable = try decoder.decode(T.self, from: data)
                print("decoded: ", decodable)
                completion(decodable)
            } catch {
                NSLog("ERROR PARSING: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}
