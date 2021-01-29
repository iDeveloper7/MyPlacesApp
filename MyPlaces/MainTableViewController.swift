//
//  MainTableViewController.swift
//  MyPlaces
//
//  Created by Vladimir Karsakov on 26.01.2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
//    var places = PlaceModel.getPlaces()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return places.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
//
//        cell.nameLabel.text = places[indexPath.row].name
//        cell.locationLabel.text = places[indexPath.row].location
//        cell.typeLabel.text = places[indexPath.row].type
//
//        if places[indexPath.row].image == nil{
//            cell.imageOfPlace.image = UIImage(named: "\(places[indexPath.row].restaurantImage!)")
//        } else{
//            cell.imageOfPlace.image = places[indexPath.row].image
//        }
//
//        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
//        cell.imageOfPlace.clipsToBounds = true
//        return cell
//    }
    
   // MARK: - Table view delegate
    
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        
        guard let newPlaceVC = segue.source as? NewPlaceTableViewController else { return }
        newPlaceVC.saveNewPlace()
//        guard let newPlaces = newPlaceVC.newPlace else { return }
//        places.append(newPlaces)
        tableView.reloadData()
    }
}
