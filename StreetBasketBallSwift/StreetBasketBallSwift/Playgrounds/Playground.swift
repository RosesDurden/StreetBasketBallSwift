//
//  Playground.swift
//  StreetBasketBallSwift
//
//  Created by Roses on 10/11/2018.
//  Copyright © 2018 Roses. All rights reserved.
//

import MapKit

class Playground: NSObject, MKAnnotation {
    
    let title: String?
    let locationName: String
    let discipline: String
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        super.init()
    }
}
