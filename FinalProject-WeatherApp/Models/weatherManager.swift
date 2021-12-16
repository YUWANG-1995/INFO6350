//
//  weatherManager.swift
//  FinalProject-WeatherApp
//
//  Created by Yu Wang on 2021/12/15.
//

import Alamofire
import Foundation
import PromiseKit
import SwiftSpinner
import SwiftyJSON

class weatherManager {
    
    
    private func getCurrentWeatherUrl(cityName: String) -> String {
        let url = "\(Constants.openWeatherAPI.baseUrl)/weather?q=\(cityName)&appid=\(Constants.openWeatherAPI.apiKey)"
        return url
    }
   
    // MARK: function - get current city weather
    
    func getCurrentWeather(cityName: String) -> Promise<cityInfo> {
        SwiftSpinner.show("fetching data ...")
        
        return Promise<cityInfo> { seal -> Void in
            
            let url = getCurrentWeatherUrl(cityName: cityName);
            
            
            AF.request(url).responseJSON {response in
                switch response.result {
                    
                case .success(let success):
                    SwiftSpinner.hide()
                    
                    let weatherData = JSON(success)
                    
                    let newCity = cityInfo()
                    newCity.cityID = weatherData["id"].stringValue
                    newCity.cityName = weatherData["name"].stringValue
                    newCity.country = weatherData["sys"]["country"].stringValue
                    newCity.temp = weatherData["main"]["temp"].stringValue
                    newCity.condition = weatherData["weather"][0]["main"].stringValue
                    seal.fulfill(newCity)
                    
                case .failure(let error):
                    SwiftSpinner.show("Failed", animated: false).addTapHandler({
                        SwiftSpinner.hide()
                    }, subtitle: "Tap to hide")
                    
                    print("Error: \(error)")
                    seal.reject(error)
                    
                }
            }
        }
    }
    
    func getAllCurrentWeather(_ citiesArray : [String]) -> Promise<[cityInfo]> {
        SwiftSpinner.show("fetching data ....")
        
        var promises: [Promise<cityInfo>] = []
        
        for oneCity in citiesArray {
            promises.append(getCurrentWeather(cityName: oneCity))
        }
        
        SwiftSpinner.hide()
        
        return when(fulfilled: promises)
    }
}


