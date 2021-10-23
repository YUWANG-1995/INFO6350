//
//  ViewController.swift
//  currencyCalculator
//
//  Created by Yu Wang on 2021/10/23.
//

import UIKit
import SwiftyJSON
import Alamofire
import SwiftSpinner

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let baseUrl = "http://api.exchangeratesapi.io/v1/latest?"
    let apiKey = "access_key=a00f75e88cafdc163d16af8de8c215ad"
    var currencySymbolLists = ["AED","AFN","ALL","AMD","ANG","AOA","ARS","AUD","AWG","AZN","BAM","BBD","BDT","BGN","BHD","BIF","BMD","BND","BOB","BRL","BSD","BTC","BTN","BWP","BYN","BYR","BZD","CAD","CDF","CHF","CLF","CLP","CNY","COP","CRC","CUC","CUP","CVE","CZK","DJF","DKK","DOP","DZD","EGP","ERN","ETB","EUR","FJD","FKP","GBP","GEL","GGP","GHS","GIP","GMD","GNF","GTQ","GYD","HKD","HNL","HRK","HTG","HUF","IDR","ILS","IMP","INR","IQD","IRR","ISK","JEP","JMD","JOD","KES","KGS","KHR","KMF","KPW","KRW","KWD","KYD","KZT","LAK","LBP","LKR","LRD","LSL","LVL","LYD","MAD","MDL","MGA","MKD","MMK","MNT","MOP","MRO","MUR","MVR","MWK","MXN","MYR","MZN","NAD","NGN","NIO","NOK","NPR","NZD","OMR","PAB","PEN","PGK","PHP","PKR","PLN","PYG","QAR","RON","RSD","RUB","RWF","SAR","SBD","SCR","SDG","SEK","SGD","SHP","SLL","SOS","SRD","STD","SVC","SYP","SZL","THB","TJS","TMT","TND","TOP","TRY","TTD","TWD","TZS","UAH","UGX","USD","UYU","UZS","VEF","VND","VUV","WST","XAF","XAG","XCD","XDR","XOF","XPF","YER","ZAR","ZMK","ZMW","ZWL"]
    
    @IBOutlet weak var fromPicker: UIPickerView!
    
    @IBOutlet weak var toPicker: UIPickerView!
    
    @IBOutlet weak var lblResult: UILabel!
    
    var target: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fromPicker.delegate = self
        fromPicker.dataSource = self
        toPicker.delegate = self
        toPicker.dataSource = self
    }
    
    @IBAction func convert(_ sender: Any) {
        var fromCurrency = currencySymbolLists[fromPicker.selectedRow(inComponent: 0)]
        var toCurrency = currencySymbolLists[toPicker.selectedRow(inComponent: 0)]
        
        let url = baseUrl + apiKey
        AF.request(url).responseJSON { response in
            if response.error != nil {
                print(response.error)
                return;
            }
            
            let result = JSON(response.data)
            var fromCurr:Double = result["rates"][fromCurrency].doubleValue
            var toCurr:Double = result["rates"][toCurrency].doubleValue
            let curr:Double = toCurr/fromCurr
            
            self.lblResult.text = "\(fromCurrency) to \(toCurrency) rate is \(curr)"
            
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencySymbolLists.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencySymbolLists[row]
    }
}

