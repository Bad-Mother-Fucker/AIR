//
//  Tratta.swift
//  AIR
//
//  Created by alfonso on 28/08/18.
//  Copyright © 2018 alfonso. All rights reserved.
//

import Foundation

class Tratta:Hashable{
    
    var hashValue: Int{
        return cittàDiPartenza.hashValue ^ cittàDiArrivo.hashValue &* 16777619
    }
    
    static func == (lhs: Tratta, rhs: Tratta) -> Bool {
        return lhs.cittàDiArrivo == rhs.cittàDiArrivo && lhs.cittàDiPartenza == rhs.cittàDiPartenza
    }
    
    let cittàDiPartenza:String
    let cittàDiArrivo:String
   
    
    init(da partenza:String,a arrivo:String){
        cittàDiPartenza = partenza
        cittàDiArrivo = arrivo
    }
}


