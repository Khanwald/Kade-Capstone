//
//  ViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 12/9/22.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    
    struct User {
      static var currentUser: String = ""
    }
    
    
    override func viewDidAppear(_ animated: Bool)  {
        super.viewDidAppear(animated)

        
    }
    
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

