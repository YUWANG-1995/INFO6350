//
//  CitiesViewController.swift
//  FinalProject-WeatherApp
//
//  Created by Yu Wang on 2021/12/14.
//

import UIKit
import Firebase
import Alamofire
import SwiftyJSON
import PromiseKit
import grpc

class CitiesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // get database
    let db = Firestore.firestore()
    // weather manager
    let manager = weatherManager()
    // save CityInfo type data
    var cityArray: [cityInfo] = []
    
    override func viewDidLoad() {
        print("view did load")
        super.viewDidLoad()
        tableView.dataSource = self
        // hidd back button
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: "CityCard", bundle: nil), forCellReuseIdentifier: "cityCell")
    }
    
    // lifecycle hook
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
        loadCityInfo()
    }
    
    
//MARK: - Actions
    
    // logout button
    @IBAction func LogOutButton(_ sender: Any) {
        do {
            // sign out action
            try Auth.auth().signOut()
            // back to welcome page.
            navigationController?.popToRootViewController(animated: true)
        } catch let signoutError as NSError {
            // display sign out error
            print("Sign out Error \(signoutError)")
        }
    }
    
// MARK: - Functions
    
    //  function: load all cities current weather, and save to array
    func loadCityInfo() {
       // get current user
       let user = Auth.auth().currentUser!
       let username = user.email!
        
       let docRef = db.collection(Constants.collectionName).document(username)
        
        docRef.getDocument { (document, error) in
                    // existed and get data
            if let document = document, document.exists {
                // get city list
                let cityList: [String] = document.get("cityName")! as! [String]
                // for loop and use weather API to get all current Weather
                self.manager.getAllCurrentWeather(cityList)
                    .done { cityInfoArray in
                        print("get data success, \(cityInfoArray.count)")
                        self.cityArray.removeAll()
                        self.cityArray = cityInfoArray
                        self.tableView.reloadData()
                    }
                    .catch { error in
                        print("get All Data failed")
                    }
                
            } else {
                print("this user do not have any data!")
            }
        }
    }
}
    

// MARK: - Data Source
  
extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let city = cityArray[indexPath.row]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityCard
        
        print("condition -> \(city.condition)")
        cell.CityLabel.text = city.cityName
        cell.ConditaionLabel.text = city.condition
        cell.TempLabel.text = "\(city.temp)ºF"
        
        
        return cell
    }

}



