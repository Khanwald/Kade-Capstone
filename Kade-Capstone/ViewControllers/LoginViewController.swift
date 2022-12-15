//
//  LoginViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 12/10/22.
//


import UIKit
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Auths user with username
    //I did it!
    
    @IBAction func loginButton(_ sender: Any) {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else{return}
        
        var ref: DatabaseReference
        ref = Database.database().reference(withPath: "users")
        
        ref.child(username).child("email").observeSingleEvent(of: .value){ (snapshot) in
            let data:String = snapshot.value as! String
            
            Auth.auth().signIn(withEmail: data, password: password) { (authResult, error) in
                if let error = error{
                    print(error)
                } else {
                    ViewController.User.currentUser = username
                    self.performSegue(withIdentifier: "loginToHome", sender: nil)
                }
            }
            
        }
    }
}
