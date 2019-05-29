//
//  Playground.swift
//  StreetBasketBallSwift
//
//  Created by Roses on 10/11/2018.
//  Copyright © 2018 Roses. All rights reserved.
//

import UIKit
import os.log
import CoreLocation

class Playground: NSObject, NSCoding {
    
    //MARK: Properties
    
    //Structure pour l'accès au repas PropertyKey.name par exemple
    struct PropertyKey{
        static let titre = "titre"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let depCode = "depCode"
        static let comLib = "comLib"
        static let equEclairage = "equEclairage"
        static let natureSolLib = "natureSolLib"
        static let natureLibelle = "natureLibelle"
        //static let photo = "photo"
        //static let rating = "rating"
    }
    
    //MARK: Chemin d'archives
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("playgrounds")
    
    var titre: String
    var latitude: String
    var longitude: String
    var depCode: String
    var comLib: String
    var equEclairage: String
    var natureSolLib: String
    var natureLibelle: String
    //var photo: UIImage?
    //var rating: Int
    
    var location: CLLocation {
        return CLLocation(latitude: Double(self.latitude)!, longitude: Double(self.longitude)!)
    }
    
    //MARK: Initialization
    
    init?(titre: String, latitude: String, longitude: String, depCode: String, comLib: String, equEclairage: String,
          natureSolLib: String, natureLibelle:String) {
        
        // The name must not be empty
        guard !titre.isEmpty else {
            return nil
        }
        
        // La latitude et la longitude ne doivent pas être nulles
        guard !latitude.isEmpty else{
            return nil
        }
        guard !longitude.isEmpty else{
            return nil
        }
        
        guard !depCode.isEmpty else{
            return nil
        }
        
        guard !comLib.isEmpty else{
            return nil
        }
        
        guard !equEclairage.isEmpty else{
            return nil
        }
        
        guard !natureSolLib.isEmpty else{
            return nil
        }
        
        guard !natureLibelle.isEmpty else{
            return nil
        }
        
        // Initialize stored properties.
        self.titre = titre
        self.latitude = latitude
        self.longitude = longitude
        self.depCode = depCode
        self.comLib = comLib
        self.equEclairage = equEclairage
        self.natureSolLib = natureSolLib
        self.natureLibelle = natureLibelle
        //self.photo = photo
        //self.rating = rating
        
    }
    
    //MARK: NSCoding
    //Encode chaque propriété du terrain and le stocke avec la clé correspondante
    func encode(with aCoder: NSCoder) {
        aCoder.encode(titre, forKey: PropertyKey.titre)
        aCoder.encode(latitude, forKey: PropertyKey.latitude)
        aCoder.encode(longitude, forKey: PropertyKey.longitude)
        aCoder.encode(depCode, forKey: PropertyKey.depCode)
        aCoder.encode(comLib, forKey: PropertyKey.comLib)
        aCoder.encode(equEclairage, forKey:PropertyKey.equEclairage)
        aCoder.encode(natureSolLib, forKey:PropertyKey.natureSolLib)
        aCoder.encode(natureLibelle, forKey:PropertyKey.natureLibelle)
        //aCoder.encode(photo, forKey: PropertyKey.photo)
        //aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    func distance(to location: CLLocation) -> CLLocationDistance {
        return location.distance(from: self.location)
    }
    
    //Décodeur.
    //required --> cet initialiseur dit qu'il doit être implémenté dans chaque sous classe si la sous-classe définie son propre initaliseur
    //convenience --> Initaliseur secondaire, Doit appelé a initialiseur désigné dans la même classe
    //? --> C'est un initialiseur qui peut être défaillant, il retourne alors nil
    required convenience init?(coder aDecoder: NSCoder) {
        //Le nom est requis. Si on ne peut pas décoder le nom, l'initaliseur échoue
        guard let titre = aDecoder.decodeObject(forKey: PropertyKey.titre) as? String
            else {
                os_log("Le nom de l'objet Playground n'a pas pu être décodé", log: OSLog.default, type: .debug)
                return nil
        }
        
        guard let latitude = aDecoder.decodeObject(forKey: PropertyKey.latitude) as? String
            else {
                os_log("La latitude de l'objet Playground n'a pas pu être décodée", log: OSLog.default, type: .debug)
                return nil
        }
        
        guard let longitude = aDecoder.decodeObject(forKey: PropertyKey.longitude) as? String
            else {
                os_log("La longitude de l'objet Playground n'a pas pu être décodée", log: OSLog.default, type: .debug)
                return nil
        }
        
        guard let depCode = aDecoder.decodeObject(forKey: PropertyKey.depCode) as? String
        else{
            os_log("Le code du département de l'objet Playground n'a pas pu être décodée", log:OSLog.default, type:.debug)
            return nil
        }
        
        guard let comLib = aDecoder.decodeObject(forKey: PropertyKey.comLib) as? String
            else{
                os_log("Le libellé de la commune n'a pas pu être décodé", log:OSLog.default, type:.debug)
                return nil
        }
        
        guard let equEclairage = aDecoder.decodeObject(forKey: PropertyKey.equEclairage) as? String
            else{
                os_log("La présence d'éclairage n'a pas pu être décodée", log:OSLog.default, type:.debug)
                return nil
        }
        
        guard let natureSolLib = aDecoder.decodeObject(forKey: PropertyKey.natureSolLib) as? String
            else{
                os_log("La nature du sol n'a pas pu être décodée", log:OSLog.default, type:.debug)
                return nil
        }
        
        guard let natureLibelle = aDecoder.decodeObject(forKey:PropertyKey.natureLibelle) as? String
            else{
                os_log("La nature du terrain n'a pas pu être décodée", log:OSLog.default, type:.debug)
                return nil
        }
        
        //La photo est un élement optionnel du repas, donc on peut le mettre en conditionnel
        //let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        //Idem pour le rating. On utilise ici decodeInteger
        //let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        //On doit appeler l'initialiseur désigné
        self.init(titre: titre, latitude: latitude, longitude: longitude, depCode:depCode, comLib:comLib, equEclairage:equEclairage,
                  natureSolLib:natureSolLib,natureLibelle:natureLibelle)
    }
}
