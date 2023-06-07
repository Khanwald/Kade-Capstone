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
        KeyboardHelper.addKeyboardDismissRecognizer(to: view)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signupToHome" {
            segue.destination.modalPresentationStyle = .fullScreen
        }
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
                ViewController.User.currentUser = username
                
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
                    let user = Auth.auth().currentUser
                    let changeRequest = user?.createProfileChangeRequest()
                    changeRequest?.displayName = username

                    changeRequest?.commitChanges { (error) in
                      if let error = error {
                        // An error occurred while updating the user's profile
                          print(error)
                      } else {
                        // The user's display name was successfully updated
                          print("success")
                      }
                    }
                    self.performSegue(withIdentifier: "signupToHome", sender: nil)
                }
                
            }
            
        }
        
        
    }
}
