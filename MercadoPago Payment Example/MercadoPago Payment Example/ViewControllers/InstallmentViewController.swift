//
//  InstallmentViewController.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 02/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import UIKit

protocol InstallmentViewControllerDelegate: class {
    func selectedInstallment(_ installment: Installment)
}

class InstallmentViewController: UIViewController {

    // TODO: make baseViewController & CollectionViewController
    
    @IBOutlet weak var collectionView: UICollectionView!

    var installments: [Installment]! = []
    var paymentMethod: PaymentMethod!
    var amount: Int!
    var cardIssuer: CardIssuer!

    let cellReuseIdentifier = "TitleCell"
    let cellNibName = "TitleCollectionViewCell"

    weak var delegate: InstallmentViewControllerDelegate?

    init(paymentMethod: PaymentMethod, amount: Int, cardIssuer: CardIssuer) {
        self.paymentMethod = paymentMethod
        self.amount = amount
        self.cardIssuer = cardIssuer
        super.init(nibName: "FingerSizeCollectionView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        //self.collectionView.collectionViewLayout = XColumnsCollectionViewFlowLayout(numberOfColumns: 1)
        
        self.collectionView.register(UINib(nibName: self.cellNibName, bundle: nil), forCellWithReuseIdentifier: self.cellReuseIdentifier)
        
        self.title = NSLocalizedString("installmentTitle", comment: "")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        fillInstallments()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillInstallments() {
        guard let paymentMethod = paymentMethod, let amount = amount, let cardIssuer = cardIssuer else { return } // TODO: optionals?
        
        let connector = InstallmentConnector()
        connector.getInstallments(paymentMethod: paymentMethod, amount: amount, cardIssuer: cardIssuer) { (installments) in
            guard let installments = installments else {
                self.showGlobalError {
                    self.fillInstallments()
                }
                return
            }
            self.installments = installments
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
}

extension InstallmentViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemSelected = self.installments[indexPath.row]
        self.delegate?.selectedInstallment(itemSelected)
    }
    
}

extension InstallmentViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.installments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellReuseIdentifier, for: indexPath) as! TitleCollectionViewCell
        
        cell.titleLabel.text = self.installments[indexPath.row].recommendedMessage
        
        return cell
    }
    
}
