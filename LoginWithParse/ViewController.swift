//
//  ViewController.swift
//  LoginWithParse
//
//  Created by Shikha Gupta on 16/12/16.
//  Copyright © 2016 shikha. All rights reserved.
//

import UIKit
import  Parse
class ViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    var activityIndicator = UIActivityIndicatorView()
    
    var alertDialog = UIAlertController()
    
    
    override func viewDidAppear(_ animated: Bool) {
        let user = PFUser.current()
        
        guard user == nil else {
            performSegue(withIdentifier: "showHome", sender: self)
            return
        }
        
    }
    
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
            startActivityIndicator()
            
            PFUser.logInWithUsername(inBackground: email.text!, password: password.text!, block: { (user, error) in
                
                self.stopActivityIndicator()
                
                if error != nil  {
                    
                    var defaultError = "Please try again later!!!"
                    
                    if let errorMessage = (error as! NSError).userInfo["error"] as? String
                    {
                        defaultError = errorMessage
                    }
                    self.showAlert(title: "Login Error", message: defaultError)
                    
                }else{
                    
                    self.showAlert(title: "Login Successful", message: "You have successfully Logged in",action: UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                        self.alertDialog.dismiss(animated: true, completion: nil)
                        self.clearInputFields()
                        self.performSegue(withIdentifier: "showHome", sender: self)
                    }))
                }
                
                
            })
            
            
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
    
    
    func showAlert(title: String,message: String,action:UIAlertAction)
    {
        let alertDialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertDialog.addAction(action)
        self.present(alertDialog, animated: true, completion: nil)
    }
    
    
    @IBAction func signup(_ sender: Any) {
        performSegue(withIdentifier: "showSignUp", sender: self)
    }
    
    func clearInputFields()
    {
        email.text = ""
        password.text = ""
    }
    
    func startActivityIndicator()
    {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        view.addSubview(activityIndicator)
        UIApplication.shared.beginIgnoringInteractionEvents()
        activityIndicator.startAnimating()
    }
    
    
    func stopActivityIndicator()
    {
        UIApplication.shared.endIgnoringInteractionEvents()
        activityIndicator.stopAnimating()
        
    }
    
}

