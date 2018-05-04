//
//  TwoColumnsCollectionViewFlowLayout.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 02/05/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import UIKit

class XColumnsCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var numberOfColumns: Int = 2

    init(numberOfColumns: Int) {
        self.numberOfColumns = numberOfColumns
        super.init()
        setup()
    }
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        self.scrollDirection = .vertical
    }
    
    override var itemSize: CGSize {
        set { }
        get {
            let width = self.collectionView!.frame.width / CGFloat(self.numberOfColumns)
            return CGSize(width: width, height: width)
        }
    }
    
}
