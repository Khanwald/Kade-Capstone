//
//  BlockCollectionViewCell.swift
//  Kade-Capstone
//
//  Created by 11k on 1/13/23.
//

import UIKit

class BlockCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var block: UITextField!
    
    override func awakeFromNib() {
            block.delegate = self
    }
        
    @IBAction func changed(_ sender: Any) {
        let a = block.text!
        
        let b = a.last!
        // Output: "o"

        block.text = String(b)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if block.text!.count > 1{
            if let a = block.text, let b = a.last{
                block.text = String(b)
            }
            return false
        }
        

        
        return true
    }
    
    
    

}
