//
//  PlaygroundsTableViewCell.swift
//  StreetBasketBallSwift
//
//  Created by Roses on 21/11/2018.
//  Copyright © 2018 Roses. All rights reserved.
//

import UIKit

class PlaygroundsTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var playgroundImage: UIImageView!
    @IBOutlet weak var playgroundTitre: UILabel!
    @IBOutlet weak var playgroundDistanceTerrain: UILabel!
    @IBOutlet weak var playgroundNoteTerrain: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
