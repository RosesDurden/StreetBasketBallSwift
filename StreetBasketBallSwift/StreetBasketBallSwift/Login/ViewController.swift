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
import FBSDKLoginKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        if(FBSDKAccessToken.current() != nil) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "homevc")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //Facebook bouton de connexion
        let boutonDeLogin = LoginButton(readPermissions: [ .publicProfile ])
        boutonDeLogin.center = view.center
        view.addSubview(boutonDeLogin)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

