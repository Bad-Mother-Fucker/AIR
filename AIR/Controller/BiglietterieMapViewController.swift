//
//  BiglietterieMapViewController.swift
//  AIR
//
//  Created by Michele De Sena on 01/10/2018.
//  Copyright © 2018 alfonso. All rights reserved.
//

import UIKit
import MapKit

class BiglietterieMapViewController: UIViewController,CLLocationManagerDelegate {
    
    @IBOutlet weak var mappa: MKMapView!
    
    var currentLocation: CLLocation{
        get{
            return CLLocation(latitude: currentLatitude, longitude: currentLongitude)
        }
    }
    let locationManager = CLLocationManager()
    private var currentLatitude: CLLocationDegrees = 40.910555555555554
    private var currentLongitude: CLLocationDegrees = 14.920277777777777
    var distanceRadius: CLLocationDistance = 3000

    func startSignificantLocationChangeUpdate(){
        locationManager.desiredAccuracy = 50
        locationManager.delegate = self
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func centerMapOn(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: distanceRadius, longitudinalMeters: distanceRadius)
        mappa.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startSignificantLocationChangeUpdate()
        centerMapOn(location: currentLocation)
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let eventDate = location?.timestamp
        guard let howRecent = eventDate?.timeIntervalSinceNow else {return}
        
        if abs(howRecent) < 15.0 {
            currentLongitude = location?.coordinate.longitude ?? 40.910555555555554
            currentLatitude = location?.coordinate.latitude ?? 14.920277777777777
            
            print(currentLongitude, currentLatitude)
        }
    }
    

}


