//
//  REST.swift
//  MyCars
//
//  Created by Usuário Convidado on 29/03/17.
//  Copyright © 2017 FIAP. All rights reserved.
//

import Foundation
import UIKit

class REST {
    
    static let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = false
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.timeoutIntervalForRequest = 30
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        
        return configuration
    }()
    static let session = URLSession(configuration: configuration) //URLSession.shared
    static let basePath = "https://fiapcars.herokuapp.com/cars"
    
    //GET
    static func loadCars(onComplete: @escaping ([Car]?) -> Void) {
        guard let url = URL(string: basePath) else {
            onComplete(nil)
            return
        }
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {return}
                if response.statusCode == 200 {
                    guard let data = data else {return}
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [[String: Any]] {
                         
                            var cars: [Car] = []
                            for item in json {
                                let brand = item["brand"] as! String
                                let name = item["name"] as! String
                                let price = item["price"] as! Double
                                let gasType = GasType(rawValue: item["gasType"] as! Int)!
                                let car = Car(brand: brand, name: name, price: price, gasType: gasType)
                                car.id = item["id"] as! String
                                cars.append(car)
                            }
                            
                            onComplete(cars)
                            
                        } else {
                            print("Deu ruim na serialização do JSON")
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                } else {
                    print("Servidor respondeu:", response.statusCode)
                }
                
            } else {
                print("Deu erro!!!")
                onComplete(nil)
            }
        }.resume()
    }
    
    //POST
    static func saveCar(car: Car) {
        guard let url = URL(string: basePath) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let carDict:[String: Any] = ["brand": car.brand, "name": car.name, "price": car.price, "gasType": car.gasType.rawValue]
        let json = try! JSONSerialization.data(withJSONObject: carDict, options: JSONSerialization.WritingOptions())
        request.httpBody = json
        
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {return}
                
                let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String: Any]
                
                print(json)
                
            }
        }.resume()
    }
    
    //DELETE
    static func deleteCar(car: Car) {
        guard let url = URL(string: "\(basePath)/\(car.id!)") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {return}
                
                let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String: Any]
                
                print(json)
            }
        }.resume()
    }
    
    
    
    //PATCH
    static func updateCar(car: Car) {
        guard let url = URL(string: "\(basePath)/\(car.id!)") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        let carDict:[String: Any] = ["brand": car.brand, "name": car.name, "price": car.price, "gasType": car.gasType.rawValue]
        let json = try! JSONSerialization.data(withJSONObject: carDict, options: JSONSerialization.WritingOptions())
        request.httpBody = json
        session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data else {return}
                
                let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String: Any]
                
                print(json)
                
            }
            }.resume()
    }

}







