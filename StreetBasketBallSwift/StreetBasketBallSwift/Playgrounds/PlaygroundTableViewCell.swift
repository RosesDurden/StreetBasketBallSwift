//
//  PlaygroundTableViewCell.swift
//  StreetBasketBallSwift
//
//  Created by Roses on 01/12/2018.
//  Copyright © 2018 Roses. All rights reserved.
//
import Foundation
import UIKit

class PlaygroundTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
