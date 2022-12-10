//
//  CollectionViewCell.swift
//  Kade-Capstone
//
//  Created by 11k on 12/9/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    
    static let identifer = "cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    public func configure(with term:String?, with definition:String?){
        guard let term = term, let definition = definition else{return}
        
        termLabel.text = term
        definitionLabel.text = definition
    }
}
