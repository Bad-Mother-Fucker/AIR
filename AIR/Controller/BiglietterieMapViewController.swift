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

    
    var biglietterie = Constants.biglietterie 
    var distanza: Int! = 10

//    func sortBiglietterie(){
//        DispatchQueue.main.async {
//            self.biglietterie?.sort(by: { (lhs, rhs) -> Bool in
//                return lhs.distanceFromMe < rhs.distanceFromMe
//            })
//            self.elenco.reloadData()
//            self.elenco.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        }
//    }

    
    
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
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "raggio di azione"), style:.plain, target: self, action: #selector(filterResults(_ :)))
            elenco.isHidden = false
            mappa.isHidden = true
            
        default:
            break
        }
    }
    
    @objc func filterResults(_ sender: UIBarButtonItem){
        performSegue(withIdentifier: "filterResults", sender: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        startLocationUpdate()
        mappa.delegate = self
        elenco.delegate = self
        elenco.dataSource = self
        mappa.register(BiglietteriaAnnotationView.self,
                       forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mappa.showsScale = true
        addAnnotationsData(fromFileNamed: "Biglietterie")
        setSegmentedControl()
        NotificationCenter.default.addObserver(forName: .reloadViews, object: nil, queue: nil) { (notifica) in
            guard let value = notifica.userInfo!["value"] else{return}
            
            
            DispatchQueue.main.async {
                self.distanza = Int(value as! Float)
                self.biglietterie = Constants.biglietterie?.filter({ (biglietteria) -> Bool in
                    
                    return Int(biglietteria.distanceFromMe) < self.distanza*1000
                })
                self.elenco.reloadData()
                guard self.elenco.numberOfRows(inSection: 0) > 0 else{return}
                self.elenco.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
           
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(enableDarkMode), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disableDarkMode), name: .darkModeDisabled, object: nil)
        
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SliderViewController else{return}
        destination.lastValue = Float(self.distanza)
    }
    
}





extension BiglietterieMapViewController: MKMapViewDelegate {
    

    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let biglietteria = view.annotation as? Biglietteria else{return}
        biglietteria.apriInMappe(fromViewController: self)
    }
}


extension BiglietterieMapViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(biglietterie!.count)
        return biglietterie?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let biglietterie = self.biglietterie {
            let cell = tableView.dequeueReusableCell(withIdentifier: "biglietteria", for: indexPath)
            let l1 = cell.viewWithTag(1) as! UILabel
            let l2 = cell.viewWithTag(2) as! UILabel
            l1.text = biglietterie[indexPath.row].nome
            l2.text = "\(biglietterie[indexPath.row].indirizzo) - \(biglietterie[indexPath.row].località)"
            cell.accessoryView = AccessoryButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30),forIndexPath: indexPath,parent: self,biglietteria: biglietterie[indexPath.row] )
            return cell
        }
        return UITableViewCell()
    }
    
    
    fileprivate class AccessoryButton: UIButton {
        private var biglietteria: Biglietteria
        private var indexPath: IndexPath
        private var parent: UIViewController
        
        
        init(frame: CGRect,forIndexPath indexPath: IndexPath,parent: UIViewController,biglietteria: Biglietteria) {
            self.indexPath = indexPath
            self.parent = parent
            self.biglietteria = biglietteria
            super.init(frame: frame)
            addTarget(self, action: #selector(accessoryButtonTapped), for: .touchUpInside)
            setImage(UIImage(named: "location.png"), for: .normal)
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        
        
        @objc func accessoryButtonTapped(sender: UIButton){

            biglietteria.apriInMappe(fromViewController: parent)
        }
    }
    
    
}


extension BiglietterieMapViewController:DarkModeDelegate{
    func didEnableDarkMode() {
        
    }
    
    func didDisableDarkMode() {
        
    }
    
    
}
