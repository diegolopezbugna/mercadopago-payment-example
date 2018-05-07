//
//  ViewController.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 05/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, buttonPressed: @escaping () -> ()) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""),
                                      style: .default,
                                      handler: { action in
                                        buttonPressed()
        }))
        self.present(alert, animated: true)
    }

    func showGlobalError(buttonPressed: @escaping () -> ()) {
        let alert = UIAlertController(title: NSLocalizedString("errorTitle", comment: ""),
                                      message: NSLocalizedString("errorMessage", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("tryAgain", comment: ""),
                                      style: .default,
                                      handler: { action in
                                        buttonPressed()
        }))
        self.present(alert, animated: true)
    }
    
    func showGlobalError() {
        showGlobalError(buttonPressed: { })
    }

}
