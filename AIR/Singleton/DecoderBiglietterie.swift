//
//  DecoderBiglietterie.swift
//  AIR
//
//  Created by Michele De Sena on 02/10/2018.
//  Copyright © 2018 alfonso. All rights reserved.
//

import Foundation
import MapKit

class DecoderBiglietteria{
    
    static func loadBiglietterieDaFile(conNome nome: String) -> [Biglietterie.Biglietteria]? {
    
        if let url = Bundle.main.url(forResource: nome, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Biglietterie.self, from: data)
                return jsonData.biglietterie
            } catch {
                // handle error
                print(error.localizedDescription)
            }
        }
        
        return nil
    }
    
    
    
}







struct Biglietterie: Codable{
    struct Biglietteria: Codable {
        var località: String
        var latitudine: CLLocationDegrees
        var longitudine: CLLocationDegrees
        var indirizzo: String
        var nome: String
        
        enum CodingKeys: String,CodingKey{
             case località = "località"
             case latitudine = "Latitudine"
             case longitudine = "Longitudine"
             case indirizzo = "Indirizzo"
             case nome = "Nome"
        }
    }
    var biglietterie: [Biglietteria]
}
