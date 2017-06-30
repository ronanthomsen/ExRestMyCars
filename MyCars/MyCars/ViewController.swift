//
//  ViewController.swift
//  MyCars
//
//  Created by Usuário Convidado on 29/03/17.
//  Copyright © 2017 FIAP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tfBrand: UITextField!
    @IBOutlet weak var tfModel: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var scGasType: UISegmentedControl!
    @IBOutlet weak var btAddUpdate: UIButton!
    
    var car: Car!
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if car != nil {
            tfBrand.text = car.brand
            tfModel.text = car.name
            tfPrice.text = "\(car.price)"
            scGasType.selectedSegmentIndex = car.gasType.rawValue
            btAddUpdate.setTitle("Alterar carro", for: .normal)
            title = car.name
        } else {
            title = "Adicionar carro!"
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    
    @IBAction func addUpdate(_ sender: UIButton) {
        if car == nil {
            car = Car(brand: tfBrand.text!, name: tfModel.text!, price: Double(tfPrice.text!)!, gasType: GasType(rawValue: scGasType.selectedSegmentIndex)!)
            REST.saveCar(car: car)
        } else {
            car.name = tfModel.text!
            car.brand = tfBrand.text!
            car.price = Double(tfPrice.text!)!
            car.gasType = GasType(rawValue: scGasType.selectedSegmentIndex)!
            REST.updateCar(car: car)
        }
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Sucesso", message: "Carro salvo com sucesso!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            self.navigationController!.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}

