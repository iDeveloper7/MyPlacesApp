//
//  MainTableViewController.swift
//  MyPlaces
//
//  Created by Vladimir Karsakov on 26.01.2021.
//

import UIKit
import RealmSwift

class MainTableViewController: UITableViewController {
    
    var places: Results<PlaceModel>! //запрос к базе для отображения данных
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(PlaceModel.self) //запрашиваем объекты из realm
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let place = places[indexPath.row]
        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlace.image = UIImage(data: place.imageData!) //св-во не будет nil

//        if place.imageData == nil{
//            print("imageData = nil")
//        } else {
//            cell.imageOfPlace.image = UIImage(data: place.imageData!)
//        }
        
        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace.clipsToBounds = true
        return cell
    }
    
   // MARK: - Table view delegate
    //Удаление ячеек
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            StorageManager.deleteObject(places[indexPath.row])
        }
            tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
     //MARK: - Navigation
    //передаем данные в NewPlaceTableViewController в случае редактирования записи
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail"{ //если переход на NewPlaceTableViewController происходит по данному идентификатору
            guard let indexPath = tableView.indexPathForSelectedRow else { return } //определяем индекс текущей строки
            let place = places[indexPath.row]
            let newPlaceVC = segue.destination as! NewPlaceTableViewController
            newPlaceVC.currentPlace = place
        }
    }
    //принимаем данные из NewPlaceTableViewController
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        guard let newPlaceVC = segue.source as? NewPlaceTableViewController else { return }
        newPlaceVC.savePlace()
        tableView.reloadData()
    }
}
