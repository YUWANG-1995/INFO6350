//
//  LoginViewController.swift
//  FinalProject-WeatherApp
//
//  Created by Yu Wang on 2021/12/14.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func LoginButton(_ sender: Any) {
        if let email=EmailText.text, let password=PasswordText.text {
            // firebase auth api
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    // sign in failed
                    print(e)
                } else {
                    // navigation to city display page
                    self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
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
