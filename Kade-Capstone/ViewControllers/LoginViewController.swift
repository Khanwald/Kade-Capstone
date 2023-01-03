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
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(view:)))
//
//        view.addGestureRecognizer(tapGesture)
        KeyboardHelper.addKeyboardDismissRecognizer(to: view)

    }
    
//    @objc func dismissKeyboard(view: UIView) {
//        self.view.endEditing(true)
//    }
    
    //prepares segue so that the home menu is not a popover
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToHome" {
            segue.destination.modalPresentationStyle = .fullScreen
        }
    }
    
    //Logs user in
    @IBAction func loginButton(_ sender: Any) {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text else{return}
        
        //catches error/crash that occurs when submitting the login information with empty textfields
        if username.isEmpty || password.isEmpty{
            return
        }
        
        //Refrences the realtime database, in the 'users' parent
        var ref: DatabaseReference
        ref = Database.database().reference(withPath: "users")
        
        //Obtains the email from the associated username
        ref.child(username).child("email").observeSingleEvent(of: .value){ (snapshot) in
            let data:String = snapshot.value as! String
            
            //'data' is the email obtained from the database
            //passed through the FireAuth system to log the user in and perform segue to home
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
