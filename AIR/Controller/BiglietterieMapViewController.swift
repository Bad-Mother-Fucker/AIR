//
//  BiglietterieMapViewController.swift
//  AIR
//
//  Created by Michele De Sena on 01/10/2018.
//  Copyright © 2018 alfonso. All rights reserved.
//

import UIKit
import MapKit
import Contacts


class BiglietterieMapViewController: UIViewController {
    
    @IBOutlet weak var mappa: MKMapView!
    @IBOutlet weak var elenco: UITableView!
    
    
    var segmentedControl: UISegmentedControl!
    let biglietterie = DecoderBiglietteria.loadBiglietterieDaFile(conNome: "Biglietterie")
    let filterButton = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "raggio di azione"), style:.plain, target: self, action: #selector(filterResults))

  

    
    
    var initialLocation: (CLLocation, CLLocationDistance) {
        get {
            guard let location = locationManager.location else {
                return (CLLocation(latitude: 40.910555555555554, longitude: 14.920277777777777), 300000)
            }
            return (location,10000)
        }
    }
    
    var currentLocation: CLLocation {
        get{
            return CLLocation(latitude: currentLatitude, longitude: currentLongitude)
        }
    }
    
    let locationManager = CLLocationManager()
    private var currentLatitude: CLLocationDegrees = 40.910555555555554
    private var currentLongitude: CLLocationDegrees = 14.920277777777777
    
    
    
    private func addAnnotationsData(fromFileNamed fileName: String) {
        if let biglietterie = self.biglietterie{
            for biglietteria in biglietterie{
                let annotation = Biglietteria(nome: biglietteria.nome, indirizzo: biglietteria.indirizzo, coordinate: CLLocationCoordinate2D(latitude: biglietteria.latitudine, longitude: biglietteria.longitudine),località: biglietteria.località)
                mappa.addAnnotation(annotation)
            }
        }
    }
    
    private func showLocationAlert(){
        var message: String {
            get {
                if !CLLocationManager.locationServicesEnabled(){
                    return "Abilita i servizi di localizzazione per visualizzare i punti di interesse vicino a te"
                } else {
                    return "Negando l'accesso ai servizi di localizzazione non sarà possibile mostrare le biglietterie più vicine a te. Puoi autorizzare l'accesso dalle impostazioni"
                }
            }
        }
        
        var title: String{
            get {
                if !CLLocationManager.locationServicesEnabled(){
                    return "GPS non abilitato"
                } else {
                    return "Attenzione"
                }
            }
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Autorizza", style: .default) { _ in
            // TODO: Apri pagina dell'app in impostazioni
        }
        let action2 = UIAlertAction(title: "Più tardi", style: .cancel) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        let action3 = UIAlertAction(title: "Abilita localizzazione", style: .default) { _ in
            // TODO: Apri pagina localizzazione
        }
        
        
        
        if !CLLocationManager.locationServicesEnabled(){
            
            alert.addAction(action3)
            alert.addAction(action2)
        }else {
            
            
            alert.addAction(action1)
            alert.addAction(action2)
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func startLocationUpdate(){
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            updateLocation()
        } else {
            showLocationAlert()
        }
    }
    
    func updateLocation() {
        mappa.showsUserLocation = true
        if CLLocationManager.locationServicesEnabled(){
            locationManager.desiredAccuracy = 50
            locationManager.distanceFilter = 200
            locationManager.delegate = self
            locationManager.startMonitoringSignificantLocationChanges()
        }
    }
    
    func centerMap(onLocation location: CLLocation,radius: CLLocationDistance,animated:Bool){
        let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mappa.setRegion(coordinateRegion, animated: animated)
    }
    
    
    
    
    private func setNavBar(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
    }
    private func setSegmentedControl(){
        let items = ["Mappa", "Elenco"]
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        elenco.isHidden = true
        segmentedControl.addTarget(self, action: #selector(segmentedControlTapped), for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }
    
    @objc func segmentedControlTapped(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            navigationItem.rightBarButtonItem = nil
            elenco.isHidden = true
            mappa.isHidden = false
        case 1:
            navigationItem.rightBarButtonItem = filterButton
            elenco.isHidden = false
            mappa.isHidden = true
            
        default:
            break
        }
    }
    
    @objc func filterResults(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        startLocationUpdate()
        mappa.delegate = self
        elenco.delegate = self
        elenco.dataSource = self
        mappa.register(BiglietteriaAnnotationView.self,
                       forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mappa.showsScale = true
        addAnnotationsData(fromFileNamed: "Biglietterie")
        setSegmentedControl()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavBar()
        centerMap(onLocation: initialLocation.0,radius:initialLocation.1,animated:true)
    }
    
}

extension BiglietterieMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let eventDate = location.timestamp
        let howRecent = eventDate.timeIntervalSinceNow
        
        if abs(howRecent) < 15.0 {
            currentLongitude = location.coordinate.longitude
            currentLatitude = location.coordinate.latitude
            centerMap(onLocation: currentLocation,radius: 3000,animated:false)
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            updateLocation()
        case .denied:
            showLocationAlert()
        case .restricted:
            showLocationAlert()
        default:
            break
        }
    }
    
}





extension BiglietterieMapViewController: MKMapViewDelegate {
    
    
    func distanceFrom(_ annotation: Biglietteria) throws -> Double{
        let location = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        guard let userLoc = CLLocationManager().location else {throw Exception.userLocationUnavailable  }
        return userLoc.distance(from: location)
    }
    
    
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let biglietteria = view.annotation as? Biglietteria else{return}
        var mode = MKLaunchOptionsDirectionsModeDriving
        
        do{
            let distance = try distanceFrom(biglietteria)
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
             biglietteria.mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey:mode])
        }
        let cancel = UIAlertAction(title: "Annulla", style: .cancel) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}


extension BiglietterieMapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return biglietterie?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let biglietterie = self.biglietterie {
            let cell = tableView.dequeueReusableCell(withIdentifier: "biglietteria", for: indexPath)
            let l1 = cell.viewWithTag(1) as! UILabel
            let l2 = cell.viewWithTag(2) as! UILabel
            l1.text = biglietterie[indexPath.row].nome
            l2.text = "\(biglietterie[indexPath.row].indirizzo) - \(biglietterie[indexPath.row].località)"
            cell.accessoryView = AccessoryButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            return cell
        }
        return UITableViewCell()
    }
    
    
    
    
    
}

fileprivate class AccessoryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(accessoryButtonTapped), for: .touchUpInside)
        setImage(UIImage(named: "allarme.png"), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    @objc func accessoryButtonTapped(sender: UIButton){
        
    }
}
