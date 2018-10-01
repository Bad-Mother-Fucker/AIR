//
//  AvvisoGrandeCell.swift
//  AIR
//
//  Created by alfonso on 05/09/18.
//  Copyright © 2018 alfonso. All rights reserved.
//

import UIKit

class AvvisoGrandeCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.background.layer.cornerRadius = 20
        self.background.layer.masksToBounds = true
        
        self.titoloAvviso.isEditable = false
        self.titoloAvviso.isSelectable = false
        self.titoloAvviso.isScrollEnabled = false
      
    }
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var titoloAvviso: UITextView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCell(perAvviso avviso:FeedResponse.Item){
        let string = avviso.description.components(separatedBy: CharacterSet(charactersIn: "<p>/"))[3].lowercased()
        
        let dataOra = avviso.pubDate.dropLast(3).components(separatedBy: CharacterSet(charactersIn: " "))
        let data = dataOra[0].components(separatedBy: CharacterSet(charactersIn: "-")).reversed().joined(separator: "-")
    
        
        self.titoloAvviso.text = string.capitalizingFirstLetter()
        self.dateLabel.text = data
       
    }
    
}
