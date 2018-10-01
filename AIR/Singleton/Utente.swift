//
//  Utente.swift
//  AIR
//
//  Created by alfonso on 28/08/18.
//  Copyright © 2018 alfonso. All rights reserved.
//

import Foundation
import CloudKit
class Utente{
    static var shared = Utente()
    var nome:String?
    var cognome:String?
    var email:String?
    var setTratte = Set<Tratta>()
    var trattePreferite:[Tratta]{
        get{
            return setTratte.sorted { (t1, t2) -> Bool in
                t1.cittàDiPartenza>t2.cittàDiPartenza
            }
            
        }
    }
    
    func aggiungiAiPreferiti(_ tratta:Tratta){
        setTratte.insert(tratta)
    }
    
    
}
