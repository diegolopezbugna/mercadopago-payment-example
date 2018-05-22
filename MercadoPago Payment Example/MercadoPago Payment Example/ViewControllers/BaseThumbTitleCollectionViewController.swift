//
//  BaseViewController.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 07/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import Foundation
import UIKit

protocol ThumbTitleItem {
    var title: String? { get }
    var thumbnail: String? { get }
    var thumbnailData: Data? { set get }
}

class BaseThumbTitleCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    let thumbTitleCellReuseIdentifier = "ThumbTitleCell"
    let thumbTitleCellNibName = "ThumbTitleCollectionViewCell"

    var items: [ThumbTitleItem]! = []

    init() {
        super.init(nibName: "FingerSizeCollectionView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.collectionView.collectionViewLayout = XColumnsCollectionViewFlowLayout(numberOfColumns: 3)

        self.collectionView.dataSource = self

        self.collectionView.register(UINib(nibName: self.thumbTitleCellNibName, bundle: nil), forCellWithReuseIdentifier: self.thumbTitleCellReuseIdentifier)

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func fillItems() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
}

extension BaseThumbTitleCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.thumbTitleCellReuseIdentifier, for: indexPath) as! ThumbTitleCollectionViewCell

        cell.titleLabel.text = items[indexPath.row].title
        print(items[indexPath.row].title!)

        if let data = items[indexPath.row].thumbnailData {
            cell.thumbImageView?.image = UIImage(data: data)
        } else {
            cell.thumbImageView?.image = nil

            DispatchQueue.global().async {
                let url = URL(string: self.items[indexPath.row].thumbnail!)
                print(url!)
                if let data = try? Data(contentsOf: url!) {
                    self.items[indexPath.row].thumbnailData = data
                    DispatchQueue.main.async {
                        collectionView.reloadItems(at: [indexPath])
                        print(indexPath.row)
                    }
                }
            }
        }
        
        return cell
    }
    
}

