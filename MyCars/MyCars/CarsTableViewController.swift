//
//  CarsTableViewController.swift
//  MyCars
//
//  Created by Usuário Convidado on 29/03/17.
//  Copyright © 2017 FIAP. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {

    var dataSource: [Car] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl?.addTarget(self, action: #selector(reloadCars(refreshControl:)), for: UIControlEvents.valueChanged)
    }
    
    func reloadCars(refreshControl: UIRefreshControl) {
        loadCars()
    }
    
    func loadCars() {
        REST.loadCars { (cars: [Car]?) in
            DispatchQueue.main.async {
                if let cars = cars {
                    print("Vieram \(cars.count) carros")
                    self.dataSource = cars
                    self.tableView.reloadData()
                } else {
                    print("Ocorreu algum problema!!!")
                }
                self.refreshControl?.endRefreshing()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCars()
    }
    
    @IBAction func createCar(_ sender: UIBarButtonItem) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "ViewController")
        navigationController!.pushViewController(vc, animated: true)
    }

    // MARK: - Table view data
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let car = dataSource[indexPath.row]
        cell.textLabel?.text = car.name
        cell.detailTextLabel?.text = "\(car.price)"
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let car = dataSource[indexPath.row]
            REST.deleteCar(car: car)
            
            dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
