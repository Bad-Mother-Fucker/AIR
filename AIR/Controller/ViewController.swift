//
//  ViewController.swift
//  AIR
//
//  Created by alfonso on 26/08/18.
//  Copyright © 2018 alfonso. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TrattaPreferitaCell", bundle: nil), forCellReuseIdentifier: "trattaPreferitaCell")
        tableView.register(UINib(nibName: "AvvisiCell", bundle: nil), forCellReuseIdentifier: "avvisiCell")
//        aggiornaAvvisi()
        pureLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadViews), name: NSNotification.Name("reload data"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(mostraAvvisi), name: NSNotification.Name("Avvisi"), object: nil)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func reloadViews() {
        tableView.reloadData()
    }
    
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var searchButton: UIButton!{
        didSet{
          setButton()
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    func pureLayout(){
        settingsButton.configureForAutoLayout()
        titleLabel.configureForAutoLayout()
        searchButton.configureForAutoLayout()
       
        tableView.configureForAutoLayout()
        
        settingsButton.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        settingsButton.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        settingsButton.autoSetDimensions(to: CGSize(width: 22, height: 22))
        
        
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        titleLabel.autoSetDimensions(to: CGSize(width: 282, height: 38))
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 106)

        searchButton.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 52)
        searchButton.autoAlignAxis(toSuperviewAxis: .vertical)
        searchButton.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        searchButton.autoPinEdge(toSuperviewEdge: .right, withInset: 20, relation:.equal)
        searchButton.autoPinEdge(.bottom, to: .top, of: tableView, withOffset: -35,relation: .equal)
        searchButton.autoSetDimension(.height, toSize: 52,relation:.equal)
        
        tableView.autoPinEdge(toSuperviewEdge: .bottom)
        tableView.autoPinEdge(toSuperviewEdge: .left)
        tableView.autoPinEdge(toSuperviewEdge: .right)
        
       tableView.autoSetDimension(.height, toSize: self.view.frame.height/2, relation: .greaterThanOrEqual)
      
    }
    
    
    @objc func mostraAvvisi(){
       let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AvvisiViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func mostraTratte(){
        //present tratteViewController
    }
    
    func setButton(){
        self.searchButton.backgroundColor = .white
        self.searchButton.layer.cornerRadius = 10
        self.searchButton.layer.masksToBounds = true
        self.searchButton.layer.borderWidth = 0.5
        let imgView = UIImageView()
        self.searchButton.addSubview(imgView)
        let size = CGSize(width: 36, height:23)
        imgView.configureForAutoLayout()
        imgView.autoPinEdge(toSuperviewEdge: .top,withInset: 5)
        imgView.autoPinEdge(toSuperviewEdge: .bottom,withInset: 5)
        imgView.autoPinEdge(toSuperviewEdge: .left,withInset: 20)
        imgView.autoSetDimensions(to: size)
        imgView.image = #imageLiteral(resourceName: "threeLinesIcon")
        imgView.contentMode = .scaleAspectFit
        self.searchButton.setTitle("Cerca Destinazione", for: .normal)
        self.searchButton.setTitleColor(.black, for: .normal)
        self.searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .light)
    
    }
    
//
//    func aggiornaAvvisi() {
//        APIManager.shared.aggiornaAvvisi(onSuccess: { (response) in
//            DispatchQueue.main.async {
//                print(response.status)
//                Bacheca.avvisi.append(contentsOf: response.items)
//               NotificationCenter.default.post(Notification(name: NSNotification.Name("reload data"), object: nil))
//            }
//        }) { (error) in
//            DispatchQueue.main.async {
//
//            }
//        }
//    }
    

}



extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "trattaPreferitaCell", for: indexPath) as! TrattaPreferitaCell
            cell.setCell(perTratta:Utente.shared.trattePreferite.reversed()[indexPath.row])
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "avvisiCell", for: indexPath) as! AvvisoCell
            if (Bacheca.avvisi.count > 0){
                cell.setCell(perAvviso: Bacheca.avvisi[indexPath.row])
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let headerView = MainTableHeaderView("Tratte Preferite",frame: CGRect())
            return headerView
        default:
            let headerView = MainTableHeaderView("Avvisi",frame: CGRect(x: tableView.frame.minX, y: tableView.frame.minY, width: tableView.frame.width, height: 65))
            return headerView
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.section{
//        case 0:
//            mostraTratte()
//        case 1:
//            mostraAvvisi()
//        default:
//            break
//        }
//    }
//
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
}
