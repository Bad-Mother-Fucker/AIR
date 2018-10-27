//
//  RicercaViewController.swift
//  AIR
//
//  Created by alfonso on 31/08/18.
//  Copyright © 2018 alfonso. All rights reserved.
//

import UIKit

class RicercaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        pureLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(enableDarkMode), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disableDarkMode), name: .darkModeDisabled, object: nil)
        
    }

    
    
    
    @IBOutlet weak var backgroundView: SearchPanelView!{
        didSet{
            backgroundView.layer.cornerRadius = 20
            backgroundView.layer.masksToBounds = true
            backgroundView.pureLayout()
            backgroundView.setInputViews()
            backgroundView.setupView(withDelegate: self, andDatasource:self)
            backgroundView.layer.borderColor = UIColor.darkGray.cgColor
            backgroundView.layer.borderWidth = 0.1
          
        }
    }
    
  
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    

    func pureLayout(){
        cancelButton.configureForAutoLayout()
        titleLabel.configureForAutoLayout()
        
        cancelButton.autoPinEdge(toSuperviewEdge: .left,withInset:20)
        cancelButton.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        cancelButton.autoSetDimensions(to: CGSize(width: 53, height: 30))
        
     
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        titleLabel.autoAlignAxis(.horizontal, toSameAxisOf: cancelButton)
        titleLabel.autoSetDimension(.width, toSize: 187)
        titleLabel.autoSetDimension(.height, toSize: 41)
    
        backgroundView.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 20)
        backgroundView.autoPinEdge(toSuperviewEdge: .left,withInset:20)
        backgroundView.autoPinEdge(toSuperviewEdge: .right,withInset:20)
        backgroundView.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 20)
      
        backgroundView.autoAlignAxis(toSuperviewAxis: .vertical)
        backgroundView.autoSetDimension(.height , toSize: UIScreen.main.bounds.height * 2/3, relation:.greaterThanOrEqual)
        backgroundView.autoSetDimension(.width , toSize: UIScreen.main.bounds.width * 2/3)
        
    }
    
  
    
    
}
extension RicercaViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return backgroundView.numberOfRows(inComponent: component, forPickerView: pickerView)
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return backgroundView.titleForRow(row, inComponent: component, forPickerView: pickerView)
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        backgroundView.didSelectRow(at: row, forPickerView: pickerView)
    }

}
extension RicercaViewController: DarkModeDelegate{
    func didEnableDarkMode() {
        
    }
    
    func didDisableDarkMode() {
        
    }
    
    
}
