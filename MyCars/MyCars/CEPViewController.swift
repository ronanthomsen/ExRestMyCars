//
//  CEPViewController.swift
//  MyCars
//
//  Created by Usuário Convidado on 29/03/17.
//  Copyright © 2017 FIAP. All rights reserved.
//

import UIKit

class CEPViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        URLSession.shared.dataTask(with: URL(string: "https://viacep.com.br/ws/01311000/json/")!) { (data, response, error) in
            if error == nil {
                guard let data = data else {return}
                let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as! [String: String]
                
                print("logradouro:", json["logradouro"]!)
                print("localidade:", json["localidade"]!)
                
            }
        }.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
