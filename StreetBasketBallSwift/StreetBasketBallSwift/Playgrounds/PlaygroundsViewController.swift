//
//  PlaygroundsViewController.swift
//  StreetBasketBallSwift
//
//  Created by Roses on 10/11/2018.
//  Copyright © 2018 Roses. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import os.log

class PlaygroundsViewController : UIViewController, CLLocationManagerDelegate{
    
    // Pour contrôler ce que la mapView va afficher
    @IBOutlet weak var mapView: MKMapView!
    // Nouvelle instance de Core Location Class
    var locationManager: CLLocationManager!
    // On récupère une liste de Playground
    var playgrounds: [[NSString:AnyObject]] = []
    var terrains = [Playground]()
    
    let regionRadius: CLLocationDistance = 5000 //Permet de centrer la mapView sur un carré de 5000 mètres
    @IBOutlet weak var listeButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !hasLocationPermission() {
            let alertController = UIAlertController(title: "Le GPS doit être activé", message: "Merci d'activer le GPS dans les permissions.", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "Paramètres", style: .default, handler: {(cAlertAction) in
                //Redirect to Settings app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            })
            
            let cancelAction = UIAlertAction(title: "Annuler", style: UIAlertAction.Style.cancel)
            alertController.addAction(cancelAction)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // Vérifie si on a déjà autorisé l'app à accéder aux données ou non
        
        if hasLocationPermission() {
        let ma =
            CLLocation(latitude: (self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!) // Récupération de la position courante
            centerMapOnLocation(location: ma) // Puis on centre sur la position actuelle*/
        }
        mapView.delegate = self
        
        loadInitialData() // On charge tous les playgrounds du fichier json
        addMapTrackingButton() // On ajoute le bouton permettant de se recentrer sur notre position courante
    }
    
    // MARK: Centrer la carte à l'initialisation de la ViewController
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    //
    
    func hasLocationPermission() -> Bool {
        var hasPermission = false
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                hasPermission = false
            case .authorizedAlways, .authorizedWhenInUse:
                hasPermission = true
            }
        } else {
            hasPermission = false
        }
        
        return hasPermission
    }
    
    
    // MARK: Ajout du bouton pour le recentrage sur l'utilisateur
    func addMapTrackingButton(){
        let image = UIImage(named: "trackme") as UIImage?
        let button   = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.frame = CGRect(origin: CGPoint(x:5, y: 650), size: CGSize(width: 35, height: 35)) // Position du bouton sur la MapView
        button.setImage(image, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(PlaygroundsViewController.centerMapOnUserButtonClicked), for:.touchUpInside)
        mapView.addSubview(button)
    }
    @objc func centerMapOnUserButtonClicked() {
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
    }
    //
    
}

extension PlaygroundsViewController: MKMapViewDelegate {
    
    // MARK: Fonction appelée à chaque fois qu'on ajoute une annotation à la MapView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // On vérifie en premier lieu que l'annotation qu'on souhaite ajouter est bien un Playground
        //guard let annotation = annotation as? Playground else { return nil }
        // Créer chaque vue comme une MKMarkerAnnotationView pour faire apparaître les markers
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // Vérifie si un marker est réutilisable avant de le recharger
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // Sinon, on recrée un nouveau marker
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    //
    
    // MARK: Fonction qui dit à l'application que faire quand l'utilisateur appuie sur le bouton d'information
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let placeMarker = MKPlacemark(coordinate: (view.annotation?.coordinate)!) // Récupère les coordonnées du terrain sélectionné
        let mapItem = MKMapItem(placemark: placeMarker) // Crée un nouveau mapItem
        mapItem.name = "Terrain"
        mapItem.openInMaps() // Ouvre le terrain sélectionné dans l'appli Plans
    }
    //
    
    // MARK: On récupère les valeurs JSON
    func loadInitialData() {
        let path = Bundle.main.path(forResource: "Playgrounds", ofType: "json") // URL du fichier dans le Bundle
        if let dataPath = path {
            let data = try? Data(contentsOf: URL(fileURLWithPath: dataPath), options: .mappedIfSafe) // On récupère le contenu de l'URL
            if let data = data {
                do{
                    let jsonObject = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) // On sérialize le JSON en un objet
                    if let object = jsonObject as? [NSString: AnyObject]{
                        if let allPlaygrounds = object["playgrounds"] as? [[NSString: AnyObject]]{
                            for marker in allPlaygrounds{
                                let point = MKPointAnnotation() // Pour chaque terrain, on crée une annotation
                                let pointLatitude = (marker["EquGpsY"] as! NSString).doubleValue // Avec une latitude
                                let pointLongitude = (marker["EquGpsX"] as! NSString).doubleValue // Une longitude
                                point.title = (marker["InsNom"]! as? String)! + " - " + (marker["ComLib" ] as? String)! // Un titre
                                point.coordinate = CLLocationCoordinate2DMake(pointLatitude ,pointLongitude)
                                mapView.addAnnotation(point) // Et on l'ajoute à la mapView
                                playgrounds = allPlaygrounds
                                terrains.append(Playground.init(
                                                                titre: marker["InsNom"] as! String,
                                                                latitude: marker["EquGpsY"] as! String,
                                                                longitude: marker["EquGpsX"] as! String,
                                                                depCode: marker["DepCode"]as! String,
                                                                comLib:marker["ComLib"]as! String,
                                                                equEclairage:marker["EquEclairage"]as! String,
                                                                natureSolLib:marker["NatureSolLib"]as! String,
                                                                natureLibelle:marker["NatureLibelle"]as! String)!)
                            }
                        }
                    }
                } catch {
                    print("json error: \(error.localizedDescription)")
                }
            }
        }
    }
    //
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowList" {
            if let destinationVC = segue.destination as? PlaygroundsTableViewController {
                let maPosition = CLLocation(latitude: (self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!) //
                terrains.sort(by: {$0.distance(to: maPosition) < $1.distance(to: maPosition)})
                destinationVC.terrains = self.terrains
            }
        }
    }
    
}
