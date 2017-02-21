//
//  PotatoAddPlayerCollectionViewCell.swift
//  Roomer
//
//  Created by Albert Samuel Melo on 08/02/17.
//  Copyright © 2017 teamsug. All rights reserved.
//

import UIKit

class PotatoAddPlayerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var addImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addImage.adjustsImageWhenAncestorFocused = true
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
}
