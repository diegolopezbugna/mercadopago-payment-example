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

class PaymentMethodViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var paymentMethods: [PaymentMethod]! = []

    let thumbTitleCellReuseIdentifier = "ThumbTitleCell"
    let thumbTitleCellNibName = "ThumbTitleCollectionViewCell"

    weak var delegate: PaymentMethodViewControllerDelegate?

    init(amount: Int?) {
        super.init(nibName: "FingerSizeCollectionView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        //self.collectionView.collectionViewLayout = XColumnsCollectionViewFlowLayout(numberOfColumns: 3)
        
        self.collectionView.register(UINib(nibName: self.thumbTitleCellNibName, bundle: nil), forCellWithReuseIdentifier: self.thumbTitleCellReuseIdentifier)
        
        self.title = NSLocalizedString("paymentMethodTitle", comment: "")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        fillPaymentMethods()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillPaymentMethods() {
        let connector = PaymentMethodConnector()
        connector.getPaymentMethods { (paymentMethods) in
            guard let paymentMethods = paymentMethods else {
                // TODO: error/exception
                return
            }
            self.paymentMethods = paymentMethods
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                self.fillPaymentMethodsThumbnails()
            }
        }
    }
    
    func fillPaymentMethodsThumbnails() {
        guard let paymentMethods = paymentMethods, self.paymentMethods.count > 0 else {
            return
        }
        
        for index in 0...(paymentMethods.count - 1) {
            DispatchQueue.global().async { [weak self] in
                let url = URL(string: paymentMethods[index].thumbnail!)
                if let data = try? Data(contentsOf: url!) {
                    paymentMethods[index].thumbnailData = data
                    DispatchQueue.main.async {
                        self?.collectionView?.reloadItems(at: [IndexPath(row: index, section: 0)])
                    }
                }
            }
        }
    }
}

extension PaymentMethodViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemSelected = self.paymentMethods[indexPath.row]
        self.delegate?.selectedPaymentMethod(itemSelected)
    }
    
}

extension PaymentMethodViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.paymentMethods.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.thumbTitleCellReuseIdentifier, for: indexPath) as! ThumbTitleCollectionViewCell
        
        if let thumbData = self.paymentMethods[indexPath.row].thumbnailData {
            cell.thumbImageView?.image = UIImage(data: thumbData)
        } else {
            cell.thumbImageView?.image = nil
        }
        cell.titleLabel.text = self.paymentMethods[indexPath.row].name
        
        return cell
    }
    
}
