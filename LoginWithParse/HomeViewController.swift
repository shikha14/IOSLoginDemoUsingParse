//
//  HomeViewController.swift
//  LoginWithParse
//
//  Created by Shikha Gupta on 16/12/16.
//  Copyright © 2016 shikha. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController {

    @IBOutlet weak var detailsLabel: UILabel!
  
    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = PFUser.current()
        
        guard user == nil else {
            print(user)
            userNameLabel.text = user?.username
            detailsLabel.text = "Email id :"+(user?.email)!
            return
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logout(_ sender: Any) {
        PFUser.logOut()
        performSegue(withIdentifier: "logout", sender: self)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
