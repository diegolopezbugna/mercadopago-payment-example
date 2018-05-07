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
            self.fillThumbnails()
        }
    }
    
    func fillThumbnails() {
        guard let items = self.items, items.count > 0 else {
            return
        }
        
        for index in 0...(items.count - 1) {
            DispatchQueue.global().async { [weak self] in
                let url = URL(string: items[index].thumbnail!)
                if let data = try? Data(contentsOf: url!) {
                    self?.items[index].thumbnailData = data
                    DispatchQueue.main.async {
                        self?.collectionView?.reloadItems(at: [IndexPath(row: index, section: 0)])
                    }
                }
            }
        }
    }
}

extension BaseThumbTitleCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.thumbTitleCellReuseIdentifier, for: indexPath) as! ThumbTitleCollectionViewCell
        
        if let thumbData = items[indexPath.row].thumbnailData {
            cell.thumbImageView?.image = UIImage(data: thumbData)
        } else {
            cell.thumbImageView?.image = nil
        }
        cell.titleLabel.text = items[indexPath.row].title
        
        return cell
    }
    
}

