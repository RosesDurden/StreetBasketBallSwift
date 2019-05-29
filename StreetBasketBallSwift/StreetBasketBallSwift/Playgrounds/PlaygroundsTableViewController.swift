//
//  PlaygroundsTableViewController.swift
//  StreetBasketBallSwift
//
//  Created by Roses on 18/11/2018.
//  Copyright © 2018 Roses. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class PlaygroundsTableViewController : UITableViewController, CLLocationManagerDelegate{

    //MARK: Properties
    //var playgrounds = [[NSString:AnyObject]]() // Used with JSON based data
    var terrains = [Playground]()
    var locationManager: CLLocationManager = CLLocationManager()
    
    // number of items to be fetched each time (i.e., database LIMIT)
    let itemsPerBatch = 50
    
    // Where to start fetching items (database OFFSET)
    var offset = 0
    
    // a flag for when all database items have already been loaded
    var reachedEndOfItems = false
    
    var maPosition : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.maPosition = CLLocation(latitude: (locationManager.location?.coordinate.latitude)!,
                                      longitude: (locationManager.location?.coordinate.longitude)!) //
        //self.tableView.register(PlaygroundTableViewCell.self, forCellReuseIdentifier: "PlaygroundTableViewCell")
        //self.tableView.dataSource = self
        //self.tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return terrains.count
    //return 10
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PlaygroundTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlaygroundTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        let play = terrains[indexPath.row]
        let locationPoint = CLLocation(latitude: Double(play.latitude)!, longitude: Double(play.longitude)!)
        
        let distanceBetweenMeAndPlayground = Int(round(locationPoint.distance(from: self.maPosition!) / 1000))
        cell.nameLabel.text = "Terrain de \(play.comLib) à \(distanceBetweenMeAndPlayground) km"
        cell.ratingControl.rating = 5
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailTerrain" {
            let destinationVC = segue.destination as? PlaygroundDetailViewController
            //On récupère la cellulle concernée
            guard let selectedPlaygroundCell = sender as? PlaygroundTableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "")")
            }
            //On récupère l'index du terrain dans la liste
            guard let indexPath = tableView.indexPath(for: selectedPlaygroundCell) else {
                fatalError("La cellule choisie ne peut pas être affichée.")
            }
            //On récupère toutes les données du repas
            let selectedPlayground = terrains[indexPath.row]
            destinationVC?.terrains = [selectedPlayground]
        }
    }
    
}
