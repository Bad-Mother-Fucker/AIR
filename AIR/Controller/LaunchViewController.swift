//
//  LaunchViewController.swift
//  AIR
//
//  Created by Michele De Sena on 10/10/2018.
//  Copyright © 2018 alfonso. All rights reserved.
//

import UIKit
import SYActivityIndicatorView
import PureLayout

class LaunchViewController: UIViewController {
    
    var activity: SYActivityIndicatorView!

    @IBOutlet weak var icona: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
        activity = SYActivityIndicatorView(image: nil)
        view.addSubview(activity)
        prepare()
        pureLayout()
        
    }
    
    func pureLayout() {
        activity.configureForAutoLayout()
        activity.autoAlignAxis(.vertical, toSameAxisOf: icona, withOffset: -17)
        activity.autoPinEdge(.top, to: .bottom, of: icona, withOffset: 30)
        
    }
    
    
    func fine(){
        activity.stopAnimating()
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "start", sender: self)
    }
    
    func prepare(){
        activity.startAnimating()
        DispatchQueue.main.async {
            Constants.biglietterie?.sort(by: { (lhs, rhs) -> Bool in
               return lhs.distanceFromMe <= rhs.distanceFromMe
            })
          self.fine()
        }
    }

}
