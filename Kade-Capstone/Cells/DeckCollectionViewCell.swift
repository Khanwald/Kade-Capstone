//
//  DeckCollectionViewCell.swift
//  Kade-Capstone
//
//  Created by 11k on 12/11/22.
//

import UIKit

class DeckCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deckNameLabel: UILabel!
    
    @IBOutlet weak var creatorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    public func configure(with deckName:String){
        deckNameLabel.text = deckName
    }
}
