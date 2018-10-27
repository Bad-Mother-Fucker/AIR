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

class Biglietteria: NSObject,MKAnnotation,Codable{
    var coordinate: CLLocationCoordinate2D{
        get{
            return CLLocationCoordinate2D(latitude: latitudine, longitude: longitudine)
        }
    }
    let latitudine: CLLocationDegrees
    let longitudine: CLLocationDegrees
    let nome: String
    let indirizzo: String
    let località: String
    var title: String? {
        get {
            return nome
        }
    }
    
    var distanceFromMe: Double {
        get {
            guard let userLoc = CLLocationManager().location else {return 0}
            return userLoc.distance(from: CLLocation(latitude: latitudine, longitude: longitudine))
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
        self.latitudine = coordinate.latitude
        self.longitudine = coordinate.longitude
        self.indirizzo = indirizzo
        self.località = località
        super.init()
    }
    
    enum CodingKeys: String,CodingKey{
        case località = "località"
        case latitudine = "Latitudine"
        case longitudine = "Longitudine"
        case indirizzo = "Indirizzo"
        case nome = "Nome"
    }
    
  
    
    
    func apriInMappe(fromViewController vc: UIViewController){
        var mode = MKLaunchOptionsDirectionsModeDriving
        do{
            let distance = try CLLocationManager.distanceFrom(self)
            if distance < 2000 {
                mode = MKLaunchOptionsDirectionsModeWalking
            }
        }catch Exception.userLocationUnavailable {
            mode = MKLaunchOptionsDirectionsModeDefault
            
        }catch {
            print(error.localizedDescription)
        }
        
        let alert = UIAlertController(title: "Apri in mappe", message: "Vuoi aprire mappe e navigare verso il punto di interesse?", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            self.mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey:mode])
        }
        let cancel = UIAlertAction(title: "Annulla", style: .cancel) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        vc.present(alert, animated: true, completion: nil)
    }
    
   
    
    
}


