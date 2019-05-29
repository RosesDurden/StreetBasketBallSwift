//
//  SelectFirstDisplayNavigationController.swift
//  Bolts
//
//  Created by Roses on 09/11/2018.
//

import Foundation

import FacebookLogin
import FacebookCore
import FBSDKLoginKit

class SelectFirstDisplayNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        if(FBSDKAccessToken.current() != nil) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "goToLoginSuccessViewController")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //Facebook bouton de connexion
        let boutonDeLogin = LoginButton(readPermissions: [ .publicProfile ])
        boutonDeLogin.center = view.center
        view.addSubview(boutonDeLogin)
    }
}
