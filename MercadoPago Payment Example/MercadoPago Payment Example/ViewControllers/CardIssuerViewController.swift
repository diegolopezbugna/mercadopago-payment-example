//
//  CardIssuerViewController.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 02/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import UIKit

protocol CardIssuerViewControllerDelegate: class {
    func selectedCardIssuer(_ cardIssuer: CardIssuer)
}

extension CardIssuer: ThumbTitleItem {
    var title: String? { return name }
}

class CardIssuerViewController: BaseThumbTitleCollectionViewController {

    var paymentMethod: PaymentMethod!

    weak var delegate: CardIssuerViewControllerDelegate?

    init(paymentMethod: PaymentMethod) {
        self.paymentMethod = paymentMethod
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self // dataSource delegate is assigned on base
        self.title = NSLocalizedString("cardIssuerTitle", comment: "")
        fillCardIssuers()
    }

    func fillCardIssuers() {
        let connector = CardIssuerConnector()
        connector.getCardIssuers(paymentMethod: paymentMethod) { (cardIssuers) in
            guard let cardIssuers = cardIssuers else {
                self.showGlobalError {
                    self.fillCardIssuers()
                }
                return
            }
            self.items = cardIssuers
            self.fillItems()
        }
    }
}

extension CardIssuerViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemSelected = self.items[indexPath.row]
        self.delegate?.selectedCardIssuer(itemSelected as! CardIssuer)
    }
    
}

