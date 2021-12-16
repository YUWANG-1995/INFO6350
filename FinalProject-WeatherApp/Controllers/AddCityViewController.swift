//
//  AddCityViewController.swift
//  FinalProject-WeatherApp
//
//  Created by Yu Wang on 2021/12/15.
//

import UIKit
import Firebase


class AddCityViewController: UIViewController {

    @IBOutlet weak var cityInputText: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addCityButton(_ sender: Any) {
        // get text content
        if let cityName = cityInputText.text {
            //get username & cityname
            let user = Auth.auth().currentUser!
            let username = user.email!
            let city = cityName.lowercased()
            // get collection ref
            let docRef = db.collection(Constants.collectionName).document(username)
            
            docRef.getDocument { (document, error) in
                // check if document is already exist ?
                if let document = document, document.exists {
                    // if existed, push new data to array
                    docRef.updateData([
                        "cityName": FieldValue.arrayUnion([city])
                    ])
                } else {
                    // if not existed, create new array and save it.
                    docRef.setData([
                        "cityName": [city]
                    ]) { error in
                        if let e = error {
                            print("error in writing data, \(e)")
                        } else {
                            print("save data successful")
                            
                        }
                    }
                }
                // after all actions, clear text field and return previous viewController
                DispatchQueue.main.async {
                     self.cityInputText.text = ""
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
           

