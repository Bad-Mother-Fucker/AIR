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
    
    static func loadBiglietterieDaFile(conNome nome: String) -> [Biglietteria]? {
    
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


class Biglietterie: Decodable{
    
   
    enum CodingKeys: String, CodingKey{
        case biglietterie = "biglietterie"
    }
    
    
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        biglietterie = try values.decode([Biglietteria].self, forKey: .biglietterie)
        
    }
    
    var biglietterie: [Biglietteria]
}
