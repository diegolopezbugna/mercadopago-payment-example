//
//  PaymentMethodTableViewController.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 30/04/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import UIKit

class PaymentMethodTableViewController: UITableViewController {
    
    var paymentMethods: [PaymentMethod]! = []
    
    let thumbTitleCellReuseIdentifier = "ThumbTitleCell"
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.tableView.register(UINib(nibName: "ThumbTitleTableViewCell", bundle: nil), forCellReuseIdentifier: self.thumbTitleCellReuseIdentifier)
        
        self.title = "Payment Methods" // TODO: localization
        
        fillPaymentMethods()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paymentMethods.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.thumbTitleCellReuseIdentifier, for: indexPath) as! ThumbTitleTableViewCell

        cell.imageView?.image = nil
        cell.titleLabel.text = self.paymentMethods[indexPath.row].name
        
        return cell
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
                self.tableView?.reloadData()
                // TODO: images
            }
        }
    }
}
