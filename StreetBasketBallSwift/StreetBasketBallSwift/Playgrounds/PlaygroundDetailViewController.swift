//
//  PlaygroundDetailViewController.swift
//  StreetBasketBallSwift
//
//  Created by Roses on 04/01/2019.
//  Copyright © 2019 Roses. All rights reserved.
//

import Foundation
import UIKit

class PlaygroundDetailViewController : UIViewController{
 
    var terrains = [Playground]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Label nature = " + terrains[0].natureLibelle)
    }
    
}
