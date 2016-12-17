//
//  SignUpViewController.swift
//  LoginWithParse
//
//  Created by Shikha Gupta on 16/12/16.
//  Copyright © 2016 shikha. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var alertDialog = UIAlertController()
    
    var activityIndicator  = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
    @IBAction func registerNewUser(_ sender: Any) {
        if checkRequiredField() {
            
            startActivityIndicator()
            let user = PFUser()
            
            user.email = email.text
            user.username  = userName.text
            user.password = password.text
            user.signUpInBackground(block: { (success, error) in
                 self.stopActivityIndicator()
                if error != nil && !success {
                   
                    var message = "Please try again later!!!"
                    
                    if let errorMessage = (error as! NSError).userInfo["error"] as? String
                    {
                        message = errorMessage
                    }
                    self.showAlert(title: "Error in Signup", message:message)
                }else{
                    self.showAlert(title: "Signup Successfull", message: "You have successfully signed up",action: UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                        self.alertDialog.dismiss(animated: true, completion: nil)
                        self.clearInputFields()
                        self.performSegue(withIdentifier: "swtichToHomeFromSignUp", sender: self)
                    }))
                    
                }
                
                print(success)
            })
            
        }else{
            showAlert(title: "Error in Signup", message: "Please enter the value of all fields")
        }
        
    }
    
    func showAlert(title: String,message: String,action:UIAlertAction)
    {
        alertDialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertDialog.addAction(action)
        self.present(alertDialog, animated: true, completion: nil)
    }
    
    
    func showAlert(title: String,message: String)
    {
        alertDialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertDialog.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.alertDialog.dismiss(animated: true, completion: nil)
        }))
        self.present(alertDialog, animated: true, completion: nil)
    }
    
    func checkRequiredField() -> Bool
    {
        if email.text == "" || password.text == "" || userName.text == ""{
            return false
        }
        else{
            return true
        }
        
    }
    
    func clearInputFields()
    {
        email.text = ""
        userName.text = ""
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
