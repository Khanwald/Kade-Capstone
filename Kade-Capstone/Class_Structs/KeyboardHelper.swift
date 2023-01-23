//
//  KeyboardHelper.swift
//  Kade-Capstone
//
//  Created by 11k on 12/22/22.
//


import UIKit

class KeyboardHelper {
    
    static func addKeyboardDismissRecognizer(to view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    func dismissKeyboard(to view: UIView) {
        view.endEditing(true)
    }
}

