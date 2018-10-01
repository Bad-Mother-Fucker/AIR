//
//  Avviso.swift
//  AIR
//
//  Created by alfonso on 28/08/18.
//  Copyright © 2018 alfonso. All rights reserved.
//

import Foundation
import UIKit
class Avviso{
    let titolo:String
    let URL:String
    let foto:UIImage?
    let dataDiPubblicazione:Date
    
    init(_ titolo:String,URL:String,foto:Data?,pubblicatoIl data:Date) {
        
        guard let _ = foto else {
            self.foto = #imageLiteral(resourceName: "iconaBus")
            self.titolo = titolo
            self.URL = URL
            dataDiPubblicazione = data
            return
        }
        let image = UIImage(data: foto!)
        self.foto = image
        self.titolo = titolo
        self.URL = URL
        dataDiPubblicazione = data
    }
}
