//
//  AvvisiTableViewController.swift
//  AIR
//
//  Created by Michele De Sena on 26/09/2018.
//  Copyright © 2018 alfonso. All rights reserved.
//

import UIKit

class AvvisiTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         navigationController?.navigationBar.isHidden = false
//        tableView.scrollToRowAtIndexPath(IndexPath, atScrollPosition: .Bottom ,animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(enableDarkMode), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disableDarkMode), name: .darkModeDisabled, object: nil)
        
    }
   
    

    @IBOutlet weak var tableViewAvvisi: UITableView!{
        didSet{
            tableViewAvvisi.register(UINib(nibName: "AvvisoGrandeCell", bundle: nil), forCellReuseIdentifier: "avvisoGrandeCell")
            tableViewAvvisi.dataSource = self
            tableViewAvvisi.delegate = self
            tableViewAvvisi.estimatedRowHeight = 161
            tableViewAvvisi.rowHeight = UITableView.automaticDimension
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      navigationController?.navigationBar.isHidden = false
    }
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Bacheca.avvisi.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "avvisoGrandeCell", for: indexPath) as! AvvisoGrandeCell
        cell.setCell(perAvviso: Bacheca.avvisi[indexPath.row])
        return cell
    }
    
    
    
    
    
}


