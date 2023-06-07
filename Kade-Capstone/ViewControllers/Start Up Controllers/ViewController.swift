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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loggedIn" {
            segue.destination.modalPresentationStyle = .fullScreen
        }
    }
    
    override func viewDidAppear(_ animated: Bool)  {
        super.viewDidAppear(animated)
        if let user = Auth.auth().currentUser?.displayName{
            User.currentUser = user
        }
        if Auth.auth().currentUser != nil{
            performSegue(withIdentifier: "loggedIn", sender: nil)
        }
    }
    @IBAction func unwind(unwindSegue: UIStoryboardSegue) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: nil)
    }
}

