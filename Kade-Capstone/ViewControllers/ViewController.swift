//
//  ViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 12/9/22.
//

import UIKit

class ViewController: UIViewController {

    static var currentUser = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func singupButton(_ sender: Any) {
        performSegue(withIdentifier: "signup", sender: nil)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: nil)
    }
}

