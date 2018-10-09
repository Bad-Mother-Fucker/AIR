//
//  Constants.swift
//  AIR
//
//  Created by alfonso on 28/08/18.
//  Copyright © 2018 alfonso. All rights reserved.
//

import Foundation
import MapKit
enum Bacheca{
    static var avvisi:[FeedResponse.Item] = []
    static var biglietterie: [Biglietteria] = []
}

enum Constants{
    static var screenScale = CGSize(width: UIScreen.main.bounds.width / CGFloat(375), height: UIScreen.main.bounds.height / CGFloat(667))
    static var biglietterie = DecoderBiglietteria.loadBiglietterieDaFile(conNome: "Biglietterie")
}


extension Date{
    func toString(withFormat format:String)->String{
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let myString = formatter.string(from: self) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = format
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd
    }
    
}

extension UIButton {
    func setButton(title:String, iconName: String,width:CGFloat){
        self.backgroundColor = .white
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .highlighted)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.white, for: .highlighted)
        //self.setImage(UIImage(named: iconName), for: .normal)
        //self.setImage(UIImage(named: iconName), for: .highlighted)
        let imageWidth = self.imageView!.frame.width
        let textWidth = (title as NSString).size(withAttributes: [.font:self.titleLabel!.font]).width
        let width = textWidth + imageWidth + 24
        //24 - the sum of your insets from left and right
        //self.autoSetDimension(.width, toSize: width, relation: .equal)
        self.layoutIfNeeded()
    
    }
}



enum FakeData{
    static let tratta1 = Tratta(da: "Avellino - P.zza Kennedy", a: "Grottaminarda")
    static let tratta2 = Tratta(da: "Monteforte Irpino", a: "Avellino - Stazione")
    static let tratta3 = Tratta(da: "Summonte", a: "Trevico")
    
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension UINavigationController{
    var isNavigationBarHidden:Bool{
        return true
    }
}

enum Exception:Error{
    case userLocationUnavailable
}
