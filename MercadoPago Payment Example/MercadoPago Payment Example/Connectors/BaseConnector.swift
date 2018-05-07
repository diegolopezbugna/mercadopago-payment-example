//
//  BaseConnector.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 04/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation

class BaseConnector {

    let baseUrl = URL(string: "https://api.mercadopago.com/v1/") // TODO: move to .plist
    let publicKey = "444a9ef5-8a6b-429f-abdf-587639155d88" // TODO: move to .plist

    func requestDecodable<T: Decodable>(uri: String, queryItems: [URLQueryItem], completion: @escaping (T?) -> ()) {

        var urlComponents = URLComponents(string: uri)
        urlComponents?.queryItems = queryItems
        urlComponents?.queryItems?.append(URLQueryItem(name: "public_key", value: self.publicKey))
        guard let url = urlComponents?.url(relativeTo: self.baseUrl) else {
            NSLog("ERROR: can't form url from \(self.baseUrl?.absoluteString ?? "") \(uri)")
            completion(nil)
            return
        }
        NSLog("URL: \(url)")

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
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
    
    func requestDecodable<T: Decodable>(uri: String, completion: @escaping (T?) -> ()) {
        requestDecodable(uri: uri, queryItems: [], completion: completion)
    }

}
