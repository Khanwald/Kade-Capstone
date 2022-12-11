//
//  SignupViewController.swift
//  Kade-Capstone
//
//  Created by 11k on 12/10/22.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignupViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var reenterPassword: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signupTapped(_ sender: Any) {
        guard let email = emailTextField.text,
              let username = usernameTextField.text,
              let password = passwordTextField.text,
              let reenter = reenterPassword.text,
              let fName = firstNameTextField.text,
              let lName = lastNameTextField.text else{return}
        
        guard password == reenter else{return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error{
                print(error)
            } else{
                ViewController.currentUser = username
                
                let user = authResult?.user
                let uid = user?.uid
                
                let values = ["LastName": lName, "FirstName": fName,"email": email, "uid": uid!]
                let ref = Database.database().reference(withPath: "users/\(username)")
                ref.setValue(values) { (error, ref) in
                    if error != nil {
                        print("error")
                    } else {
                        print("New user saved to database")
                    }
                    
                }
//                print(Dictionary<String, String>(_immutableCocoaDictionary: Database.database().reference(withPath: "users/\(username)"))["uid"]!)
                self.performSegue(withIdentifier: "signupToHome", sender: nil)
            }
        }
    }
    
}
