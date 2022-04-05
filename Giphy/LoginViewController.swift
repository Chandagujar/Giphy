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
        
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth, .month, .year]
        dateComponentsFormatter.maximumUnitCount = 1
        dateComponentsFormatter.unitsStyle = .full
        dateComponentsFormatter.string(from: Date(), to: Date(timeIntervalSinceNow: 4000000))  // "1 month"
        
        let date1 = DateComponents(calendar: .current, year: 2014, month: 11, day: 28, hour: 5, minute: 9).date!
        let date2 = DateComponents(calendar: .current, year: 2015, month: 8, day: 28, hour: 5, minute: 9).date!

        let years = date2.years(from: date1)     // 0
        let months = date2.months(from: date1)   // 9
        let weeks = date2.weeks(from: date1)     // 39
        let days = date2.days(from: date1)
        print("days",days)// 273
        let hours = date2.hours(from: date1)     // 6,553
        let minutes = date2.minutes(from: date1) // 393,180
        let seconds = date2.seconds(from: date1) // 23,590,800

        let timeOffset = date2.offset(from: date1) // "9M"
        print("timeOffset",timeOffset)
        let date3 = DateComponents(calendar: .current, year: 2014, month: 11, day: 28, hour: 5, minute: 9).date!
        let date4 = DateComponents(calendar: .current, year: 2015, month: 11, day: 28, hour: 5, minute: 9).date!

        let timeOffset2 = date4.offset(from: date3) // "1y"

        let date5 = DateComponents(calendar: .current, year: 2022, month: 3, day: 28).date!
        let now = Date()
        let timeOffset3 = now.offset(from: date5) // "1w"
        var days2 = date5.days(from: now)
        print("timeOffset3",days2)
        
        var str = "03/31/2022 06:30:59"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy 'HH':'mm':'ss"
        let datestr = dateFormatter.date (from: str)
        print("str",datestr)
        
        var dsy = datestr?.days(from: now)
        print("dsv",dsy)
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
