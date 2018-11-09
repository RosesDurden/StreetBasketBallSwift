//
//  ViewController.swift
//  StreetBasketBallSwift
//
//  Created by Roses on 09/11/2018.
//  Copyright © 2018 Roses. All rights reserved.
//
import UIKit

import FacebookLogin
import FacebookCore

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        //Facebook bouton de connexion
        let boutonDeLogin = LoginButton(readPermissions: [ .publicProfile ])
        boutonDeLogin.center = view.center
        boutonDeLogin.
        view.addSubview(boutonDeLogin)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

