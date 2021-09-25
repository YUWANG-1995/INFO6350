//
//  ViewController.swift
//  CustomTableView
//
//  Created by Ashish Ashish on 9/16/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let fruits = ["apple", "banana", "cherry", "pear", "pineapple", "pomegranate", "strawberry", "watermelon"]
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.imgView.image = UIImage(named: fruits[indexPath.row])
        cell.lblImage.text = fruits[indexPath.row]
        
        return cell
        
    }


}

