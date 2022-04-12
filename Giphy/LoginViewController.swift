//
//  LoginViewController.swift
//  Giphy
//
//  Created by macbook  on 23/03/22.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import Mixpanel
import NewRelic

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // NewRelic.crashNow("This is a test crash")

        Mixpanel.mainInstance().track(event: "Sign Up", properties: [
            "source": "Pat's affiliate site",
            "Opted out of email": true
        ])
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login_With_Google(_ sender: Any) {
        
        let signInConfig = GIDConfiguration.init(clientID: "497137483807-29cp0jd6bk3g96oo43i4viufajq5dadn.apps.googleusercontent.com")
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            let emailAddress = user.profile?.email
            let fullName = user.profile?.name
            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            print(fullName,emailAddress,profilePicUrl)
        }
       
        
    }
    
    @IBAction func login_Facebook(_ sender: Any) {
        
        LoginManager.init().logIn(permissions: [Permission.publicProfile, Permission.email], viewController: self) { (loginResult) in
          switch loginResult {
          case .success(let granted, let declined, let token):
            /*
            Sample log:
              granted: [FBSDKCoreKit.Permission.email, FBSDKCoreKit.Permission.publicProfile],
              declined: [],
              token: <FBSDKAccessToken: 0x282f50fc0>
            */
              print("granted: \(granted), declined: \(declined), token: \(String(describing: token))")
          case .cancelled:
              print("Login: cancelled.")
          case .failed(let error):
            print("Login with error: \(error.localizedDescription)")
          }
          
        
        
        }
        
}
   
}
