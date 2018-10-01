//
//  TrattaPreferitaCell.swift
//  AIR
//
//  Created by alfonso on 26/08/18.
//  Copyright © 2018 alfonso. All rights reserved.
//

import UIKit

class TrattaPreferitaCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainBackground.layer.cornerRadius = 20
        self.mainBackground.layer.masksToBounds = true
        pureLayout()
    }
    
    func setCell(perTratta tratta:Tratta){
        self.cittàDiArrivo.text = tratta.cittàDiArrivo
        self.cittàDiPartenza.text = tratta.cittàDiPartenza
    }
    
    @IBOutlet weak var shadowVIew: ShadowView!
    
    @IBOutlet weak var mainBackground: UIView!
    
    @IBOutlet weak var direzioneViaggio: UIImageView!
    
    @IBOutlet weak var cittàDiPartenza: UILabel!
    @IBOutlet weak var cittàDiArrivo: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func pureLayout(){
        direzioneViaggio.configureForAutoLayout()
        cittàDiArrivo.configureForAutoLayout()
        cittàDiPartenza.configureForAutoLayout()
        
        direzioneViaggio.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
        direzioneViaggio.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        direzioneViaggio.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
        direzioneViaggio.autoSetDimension(.width, toSize: 20)
       
        cittàDiPartenza.autoPinEdge(.top, to: .top, of: direzioneViaggio )
        cittàDiPartenza.autoPinEdge(.left, to: .right, of: direzioneViaggio, withOffset: 30)
        
        cittàDiArrivo.autoPinEdge(.bottom, to: .bottom, of: direzioneViaggio)
        cittàDiArrivo.autoPinEdge(.left, to: .right, of: direzioneViaggio,withOffset: 30)
        
        
    }
    
}
