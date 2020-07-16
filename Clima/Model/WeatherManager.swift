//
//  WeatherManager.swift
//  Clima
//
//  Created by raiyan sharif on 16/7/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://samples.openweathermap.org/data/2.5/find?appid=441a2c96e139aaecac3e9e9baa19a518"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)&units=metric"
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String){
        //1.Create a URL
        //        print(urlString)
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            print(url)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(weatherData: safeData){
                        
                    }
                }
            }
            task.resume()
        }
        print("here")
        
        
    }
    func  parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self , from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(weather.conditionName)
            return weather
        } catch{
            print(error)
            return nil
        }
    }
    
    
    
    
}
