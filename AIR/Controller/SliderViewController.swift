//
//  SliderViewController.swift
//  AIR
//
//  Created by Michele De Sena on 10/10/2018.
//  Copyright © 2018 alfonso. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
    }
    
    var lastValue:Float?
    
    override func viewWillAppear(_ animated: Bool) {
        sliderView.value = lastValue ?? 10
        kmLabel.text = "\(Int(lastValue ?? 10) ) km"
        print(sliderView.value)
    }
    
    
    @IBOutlet weak var sliderView: UISlider!
    
    @IBOutlet weak var dismissButton: UIButton!{
        didSet{
            dismissButton.layer.cornerRadius = 20
            dismissButton.layer.masksToBounds = true
        }
    }
    
    
    @IBOutlet weak var imgView: UIImageView!{
        didSet{
            imgView.layer.cornerRadius = 20
            imgView.layer.masksToBounds = true
        }
    }
    
    
    @IBOutlet weak var bgView: UIView!{
        didSet{
            bgView.layer.cornerRadius = 20
            bgView.layer.masksToBounds = true
        }
    }
    
    
    @IBOutlet weak var kmLabel: UILabel!
    
    @IBAction func slider(_ sender: UISlider) {
        kmLabel.text = "\(Int(sender.value)) km"
        
    }
    
    @IBAction func dismissButton(_ sender: UISlider) {
       NotificationCenter.default.post(name: .reloadViews, object: Int(sliderView.value),userInfo:["value": sliderView.value])
          dismiss(animated: true, completion: nil)
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(enableDarkMode), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disableDarkMode), name: .darkModeDisabled, object: nil)
    }

    
}
extension SliderViewController: DarkModeDelegate{
    func didEnableDarkMode() {
        
    }
    
    func didDisableDarkMode() {
        
    }
    
    
}
