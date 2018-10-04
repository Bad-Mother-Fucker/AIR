//
//  BiglietteriaAnnotationView.swift
//  AIR
//
//  Created by Michele De Sena on 02/10/2018.
//  Copyright © 2018 alfonso. All rights reserved.
//

import UIKit
import MapKit

class BiglietteriaAnnotationView: MKAnnotationView {

    override var annotation: MKAnnotation?{
        willSet{
            guard let _ = newValue as? Biglietteria else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            clusteringIdentifier = "clusterID"
            image = UIImage(named: "location.png")
        }
    }
}
