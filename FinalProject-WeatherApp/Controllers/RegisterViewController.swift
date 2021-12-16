//
//  RegisterViewController.swift
//  FinalProject-WeatherApp
//
//  Created by Yu Wang on 2021/12/14.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        if let email = emailText.text, let password = passwordText.text {
            // firebase register api
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    // should display register error
                    print(e)
                } else {
                    // Navigation to City Display Page
                    self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
