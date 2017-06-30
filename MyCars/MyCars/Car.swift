//
//  Car.swift
//  MyCars
//
//  Created by Usuário Convidado on 29/03/17.
//  Copyright © 2017 FIAP. All rights reserved.
//

import Foundation

enum GasType: Int {
    case flex
    case alcoohol
    case gasoline
}

class Car {
    var id: String?
    var brand: String
    var name: String
    var price: Double
    var gasType: GasType
    
    init(brand: String, name: String, price: Double, gasType: GasType) {
        self.brand = brand
        self.name = name
        self.gasType = gasType
        self.price = price
    }
    
    init(_ brand: String, _ name: String, _ price: Double, _ gasType: GasType) {
        self.brand = brand
        self.name = name
        self.gasType = gasType
        self.price = price
    }
}
