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

class CardIssuerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var cardIssuers: [CardIssuer]! = []
    var paymentMethod: PaymentMethod?

    let thumbTitleCellReuseIdentifier = "ThumbTitleCell"
    let thumbTitleCellNibName = "ThumbTitleCollectionViewCell"

    weak var delegate: CardIssuerViewControllerDelegate?

    init(paymentMethod: PaymentMethod) {
        self.paymentMethod = paymentMethod
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
        
        self.title = NSLocalizedString("cardIssuerTitle", comment: "")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        fillCardIssuers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillCardIssuers() {
        guard let paymentMethod = paymentMethod else { return }
        
        let connector = CardIssuerConnector()
        connector.getCardIssuers(paymentMethod: paymentMethod) { (cardIssuers) in
            guard let cardIssuers = cardIssuers else {
                // TODO: error/exception
                return
            }
            self.cardIssuers = cardIssuers
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                self.fillCardIssuersThumbnails()
            }
        }
    }
    
    func fillCardIssuersThumbnails() {
        guard let cardIssuers = cardIssuers, self.cardIssuers.count > 0 else {
            return
        }
        
        for index in 0...(cardIssuers.count - 1) {
            DispatchQueue.global().async { [weak self] in
                let url = URL(string: cardIssuers[index].thumbnail!)
                if let data = try? Data(contentsOf: url!) {
                    cardIssuers[index].thumbnailData = data
                    DispatchQueue.main.async {
                        self?.collectionView?.reloadItems(at: [IndexPath(row: index, section: 0)])
                    }
                }
            }
        }
    }
}

extension CardIssuerViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemSelected = self.cardIssuers[indexPath.row]
        self.delegate?.selectedCardIssuer(itemSelected)
    }
    
}

extension CardIssuerViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cardIssuers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.thumbTitleCellReuseIdentifier, for: indexPath) as! ThumbTitleCollectionViewCell
        
        if let thumbData = self.cardIssuers[indexPath.row].thumbnailData {
            cell.thumbImageView?.image = UIImage(data: thumbData)
        } else {
            cell.thumbImageView?.image = nil
        }
        cell.titleLabel.text = self.cardIssuers[indexPath.row].name
        
        return cell
    }
    
}
