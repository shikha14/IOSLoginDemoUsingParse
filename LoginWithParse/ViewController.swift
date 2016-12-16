//
//  ViewController.swift
//  LoginWithParse
//
//  Created by Shikha Gupta on 16/12/16.
//  Copyright © 2016 shikha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: Any) {
        if checkRequiredField(){
            performSegue(withIdentifier: "showHome", sender: self)
        }else{
            showAlert(title: "Error in login",message: "Please enter email and password")
        }
        
        
    }
    
    
    func checkRequiredField() -> Bool
    {
        if email.text == "" || password.text == "" {
            return false
        }
        else{
            return true
        }
        
    }
    
    func showAlert(title: String,message: String)
    {
        let alertDialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertDialog.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alertDialog.dismiss(animated: true, completion: nil)
        }))
        self.present(alertDialog, animated: true, completion: nil)
    }

    @IBAction func signup(_ sender: Any) {
        performSegue(withIdentifier: "showSignUp", sender: self)
    }

}

