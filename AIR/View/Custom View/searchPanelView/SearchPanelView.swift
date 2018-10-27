//
//  searchPanelView.swift
//  AIR
//
//  Created by alfonso on 01/09/18.
//  Copyright © 2018 alfonso. All rights reserved.
//

import UIKit

class SearchPanelView: UIView {

    let cities = ["Avellino - Stazione,Avellino - P.zza Kennedy"," Summonte","Trevico","Atripalda","Grottaminarda"]
    let times = ["Mattina","Pomeriggio","Sera","Intera Giornata"]
    let stops = ["Nessuno","max 1 cambio","max 2 cambi"]
    let cityPicker = UIPickerView()
    let cityPicker2 = UIPickerView()
    let datePicker = UIDatePicker()
    let timePicker = UIPickerView()
    let stopsPicker = UIPickerView()
    var pickers = [UIPickerView]()
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    func setupView(withDelegate delegate: UIPickerViewDelegate, andDatasource datasource:  UIPickerViewDataSource){
       
        
        setPickers(withDelegate: delegate, andDatasource: datasource)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("SearchPanelView", owner: self, options: nil)
        addSubview(contentView)
    }
    
    
    @IBOutlet var textInputs: [UITextField]!{
        didSet{
            for field in textInputs{
                field.configureForAutoLayout()
            }
            setDefault()
        }
    }
    
    @IBOutlet var fieldLabel: [UILabel]!{
        didSet{
            for label in fieldLabel{
                label.configureForAutoLayout()
            }
        }
    }
    
    
    
    @IBOutlet weak var switchButton: UIButton!{
        didSet{
            switchButton.configureForAutoLayout()
        }
    }
    
    @IBOutlet var icons: [UIImageView]!{
        didSet{
            for icon in icons{
                icon.configureForAutoLayout()
                
            }
        }
    }
    
    @IBOutlet weak var searchButton: UIButton!{
        didSet{
            searchButton.layer.cornerRadius = 20
            searchButton.layer.masksToBounds = true
            searchButton.configureForAutoLayout()
        }
    }
    
    @IBAction func switchButton(_ sender: UIButton) {
        let tmp = textInputs[0].text
        textInputs[0].text = textInputs[1].text
        textInputs[1].text = tmp
    }
    
    
    @IBAction func searchButton(_ sender: UIButton) {
        let dati: [String:String] = [
            "Partenza": textInputs[0].text!,
            "Arrivo": textInputs[1].text!,
            "Data": textInputs[2].text!,
            "Fascia Oraria": textInputs[3].text!,
            "Numero Cambi": textInputs[4].text!
        ]
//        HTTPSession.shared.sendRequest(withData: dati)
    }
    
    
    
    func pureLayout(){
        
        
        icons[0].autoPinEdge(toSuperviewEdge: .top,withInset:20)
        icons[1].autoPinEdge(.top, to: .bottom, of: icons[0],withOffset:60, relation:.lessThanOrEqual)
        
        for icon in icons{
            icon.autoPinEdge(toSuperviewEdge: .left,withInset:20)
            icon.autoSetDimension(.width, toSize: 47, relation: .lessThanOrEqual)
            icon.autoSetDimension(.height, toSize: 47, relation: .lessThanOrEqual)
            icon.autoSetDimension(.width, toSize: 27, relation: .greaterThanOrEqual)
            icon.autoSetDimension(.height, toSize: 27, relation: .greaterThanOrEqual)
            icon.autoConstrainAttribute(.width, to: .height, of: icon)
            
            if icons.index(of: icon) == 0 || icons.index(of: icon) == 1{
                continue
            }
            let index = icons.index(of: icon)
            icon.autoPinEdge(.top, to: .bottom, of: icons[icons.index(before: index!)], withOffset: 40,relation: .lessThanOrEqual)
        }
        
        for field in textInputs{
            field.autoPinEdge(.left, to: .right, of: icons[textInputs.index(of: field)!], withOffset: 8)
            field.autoPinEdge(.bottom, to: .bottom, of: icons[textInputs.index(of: field)!])
            
            field.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        }
        
        for label in fieldLabel{
            label.autoPinEdge(.left, to: .right, of: icons[fieldLabel.index(of: label)!], withOffset: 8)
            label.autoPinEdge(.bottom, to: .top, of: textInputs[fieldLabel.index(of: label)!], withOffset: -2)
            
            label.autoPinEdge(.right, to: .right, of: textInputs[fieldLabel.index(of: label)!], withOffset: 0)
            label.autoSetDimension(.height, toSize: 15)
        }
        
       
        switchButton.autoPinEdge(.top, to: .bottom, of: textInputs[0], withOffset: 8)
        switchButton.autoPinEdge(.right, to: .right, of: textInputs[0])
       switchButton.autoSetDimensions(to: CGSize(width: 44, height: 44))
        
        
        
        searchButton.autoPinEdge(.left, to: .left, of: icons[4])
//        searchButton.autoPinEdge(.right, to: .right, of: textInputs[4])
        searchButton.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        searchButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: 60)
        searchButton.autoSetDimension(.height, toSize: 60)
    }
    
    
    
    func setPickers(withDelegate delegate: UIPickerViewDelegate, andDatasource datasource: UIPickerViewDataSource){
        
        pickers = [cityPicker,cityPicker2,timePicker,stopsPicker]
        datePicker.addTarget(self, action: #selector(updateDate), for: .valueChanged)
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.setDate(Date(), animated: true)
        cityPicker.delegate = delegate
        cityPicker2.delegate = delegate
        timePicker.delegate = delegate
        stopsPicker.delegate = delegate
        cityPicker.dataSource = datasource
        cityPicker2.dataSource = datasource
        timePicker.dataSource = datasource
        stopsPicker.dataSource = datasource
 
    }
    
    
    func setDefault(){
        
        let defaultValues: [String] = [Date().toString(withFormat: "dd-MM-yyyy"),"Intera Giornata","Nessuno"]
        textInputs[2].text = defaultValues[0]
        textInputs[3].text = defaultValues[1]
        textInputs[4].text = defaultValues[2]
    }
    
    func setInputViews(){
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .blue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(done))
        
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
       
        
        for tv in textInputs{
            tv.inputAccessoryView = toolBar
        }
        
        
        textInputs[0].inputView = cityPicker
        
        textInputs[1].inputView = cityPicker2
        
        textInputs[2].inputView = datePicker
        
        textInputs[3].inputView = timePicker
        
        textInputs[4].inputView = stopsPicker
    
        
        pickers = [cityPicker,cityPicker2,timePicker,stopsPicker]
        datePicker.addTarget(self, action: #selector(updateDate), for: .valueChanged)
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.setDate(Date(), animated: true)
    }
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    
    @objc func updateDate(){
        textInputs[2].text = datePicker.date.toString(withFormat: "dd-MM-yy")
    }
    
    @objc func done(){
        self.endEditing(true)
        for textView in textInputs{
            textView.reloadInputViews()
        }
    }
    
    func numberOfRows(inComponent component:Int,forPickerView pickerView: UIPickerView) -> Int{
        let index = pickers.index(of: pickerView)
        switch index {
        case 0,1:
            return cities.count
        case 2:
            return 4
        case 3:
            return 3
        default:
            
            return 1
        }
    }
    
    func numberOfComponents(forPickerView: UIPickerView){
        
    }
    
    func titleForRow(_ row:Int,inComponent component: Int,forPickerView pickerView:UIPickerView) -> String{
        let index = pickers.index(of: pickerView)
        
        switch index {
        case 0,1:
            return cities[row]
        case 2:
            return times[row]
        case 3:
            return stops[row]
        default:
            return "dummy"
        }
    }
    
    func didSelectRow(at row: Int, forPickerView picker: UIPickerView){
        let index = pickers.index(of: picker)
        
        switch index {
        case 0,1:
            textInputs[index!].text = cities[row]
        case 2:
            textInputs[3].text = times[row]
        case 3:
            textInputs[4].text = stops[row]
        default:
            break
        }
        
    }
    
    
}
