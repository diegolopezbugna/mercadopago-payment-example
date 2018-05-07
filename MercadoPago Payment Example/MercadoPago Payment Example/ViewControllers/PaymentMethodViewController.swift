//
//  PaymentMethodViewController.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 02/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import UIKit

protocol PaymentMethodViewControllerDelegate: class {
    func selectedPaymentMethod(_ paymentMethod: PaymentMethod)
}

extension PaymentMethod: ThumbTitleItem {
    var title: String? { return name }
}

class PaymentMethodViewController: BaseThumbTitleCollectionViewController {

    weak var delegate: PaymentMethodViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self // dataSource delegate is assigned on base
        self.title = NSLocalizedString("paymentMethodTitle", comment: "")
        fillPaymentMethods()
    }

    func fillPaymentMethods() {
        let connector = PaymentMethodConnector()
        connector.getPaymentMethods { (paymentMethods) in
            guard let paymentMethods = paymentMethods else {
                self.showGlobalError {
                    self.fillPaymentMethods()
                }
                return
            }
            self.items = paymentMethods
            self.fillItems()
        }
    }
    
}

extension PaymentMethodViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemSelected = self.items[indexPath.row]
        self.delegate?.selectedPaymentMethod(itemSelected as! PaymentMethod)
    }
    
}

