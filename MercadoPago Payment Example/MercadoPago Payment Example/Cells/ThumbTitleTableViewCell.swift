//
//  ThumbTitleTableViewCell.swift
//  MercadoPago Payment Example
//
//  Created by Diego López Bugna on 28/04/2018.
//  Copyright © 2018 Diego López Bugna. All rights reserved.
//

import UIKit

class ThumbTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
