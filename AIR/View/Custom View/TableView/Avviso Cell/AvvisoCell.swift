//
//  AvvisoCell.swift
//  AIR
//
//  Created by alfonso on 28/08/18.
//  Copyright © 2018 alfonso. All rights reserved.
//

import UIKit

class AvvisoCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainBackground.layer.cornerRadius = 20
        self.mainBackground.layer.masksToBounds = true
      
        self.titoloAvviso.isEditable = false
        self.titoloAvviso.isSelectable = false
        self.titoloAvviso.isScrollEnabled = false
        pureLayout()
    }
    
    @IBOutlet weak var mainBackground: UIView!
    
    @IBOutlet weak var titoloAvviso: UITextView!
    
    @IBOutlet weak var dataAvviso: UILabel!
    
    @IBOutlet weak var immagineAvviso: UIImageView!
    
    func setCell(perAvviso avviso:FeedResponse.Item){
        let string = avviso.description.components(separatedBy: CharacterSet(charactersIn: "<p>/"))[3].lowercased()
      
        let dataOra = avviso.pubDate.dropLast(3).components(separatedBy: CharacterSet(charactersIn: " "))
        let data = dataOra[0].components(separatedBy: CharacterSet(charactersIn: "-")).reversed().joined(separator: "-")
        let ora = dataOra[1]
        
        self.titoloAvviso.text = string.capitalizingFirstLetter()
        self.dataAvviso.text = data + " " + ora
        self.immagineAvviso.image = #imageLiteral(resourceName: "iconaBus")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func pureLayout(){
        self.titoloAvviso.configureForAutoLayout()
        self.immagineAvviso.configureForAutoLayout()
        self.dataAvviso.configureForAutoLayout()
        
        self.titoloAvviso.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        self.titoloAvviso.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
        self.titoloAvviso.autoSetDimension(.width, toSize: 200, relation: .lessThanOrEqual)
        self.titoloAvviso.autoSetDimension(.height, toSize: 73, relation: .lessThanOrEqual)
        self.titoloAvviso.autoPinEdge(.right, to: .left, of: immagineAvviso, withOffset: 0,relation:.lessThanOrEqual)
        
        
        self.dataAvviso.autoPinEdge(toSuperviewEdge: .bottom,withInset:5)
        self.dataAvviso.autoPinEdge(.left, to: .left, of: titoloAvviso)
        self.dataAvviso.autoSetDimensions(to: CGSize(width: 120, height: 20))
        
        self.immagineAvviso.autoPinEdge(.top, to: .top, of: titoloAvviso,withOffset: 5)
        self.immagineAvviso.autoPinEdge(toSuperviewEdge: .right, withInset: 40)
        self.immagineAvviso.autoSetDimensions(to: CGSize(width: 75, height: 75))
    }
    

}
