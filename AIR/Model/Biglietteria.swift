//
//  Biglietteria.swift
//  AIR
//
//  Created by Michele De Sena on 01/10/2018.
//  Copyright © 2018 alfonso. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Biglietteria: NSObject,MKAnnotation{
    let coordinate: CLLocationCoordinate2D
    let nome: String
    let indirizzo: String
    let località: String
    var title: String? {
        get {
            return nome
        }
    }
    
    var subtitle: String? {
        get {
            return "\(indirizzo) - \(località)"
        }
    }
    
    var mapItem: MKMapItem {
        get {
            let addressDict = [CNPostalAddressStreetKey: "\(indirizzo) - \(località)"]
            let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
            let mapItem = MKMapItem(placemark: placemark)
            return mapItem
        }
    }
    
    
    init(nome: String,indirizzo:String, coordinate: CLLocationCoordinate2D, località: String) {
        self.nome = nome
        self.coordinate = coordinate
        self.indirizzo = indirizzo
        self.località = località
        super.init()
    }
    
    
    
}


