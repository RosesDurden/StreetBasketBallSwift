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

class PlaygroundsViewController : UIViewController, CLLocationManagerDelegate{
    
    // Pour contrôler ce que la mapView va afficher
    @IBOutlet weak var mapView: MKMapView!
    // Nouvelle instance de Core Location Class
    var locationManager: CLLocationManager!

    
    //Permet de centrer la mapView sur un carré de 1000 mètres
    let regionRadius: CLLocationDistance = 5000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        // Vérifie si on a déjà autorisé l'app à accéder aux données ou non
        locationManager.requestWhenInUseAuthorization()
        let maPosition = CLLocation(latitude: (self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!)
        centerMapOnLocation(location: maPosition)
        
        //Ajouter un Playground sur la MAP
        let playground = Playground(title: "Terrain d'entraînement de Mundolsheim",
                                    locationName: "Mundolsheim",
                                    discipline: "Basket",
                                    coordinate: CLLocationCoordinate2D(latitude: 48.6445, longitude: 7.71397))
        mapView.addAnnotation(playground)

        mapView.delegate = self
    }
}

extension PlaygroundsViewController: MKMapViewDelegate {
    // Fonction appelée à chaque fois qu'on ajoute une annotation à la MapView
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // On vérifie en premier lieu que l'annotation qu'on souhaite ajouter est bien un Playground
        guard let annotation = annotation as? Playground else { return nil }
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
}
