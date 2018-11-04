//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login


import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    @IBOutlet weak var EmailError: UILabel!
    @IBOutlet weak var passwardError: UILabel!
    @IBOutlet weak var Errormessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {
        SVProgressHUD.show()

        FIRAuth.auth()?.signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!, completion: { (user, error) in
            if error != nil{
                print(error!)
                SVProgressHUD.dismiss()
                if self.emailTextfield.text == ""{self.passwardError.isHidden = true
                    self.Errormessage.isHidden = true
                    
                    self.EmailError.isHidden = false                }
                else if self.passwordTextfield.text == ""{
                    self.EmailError.isHidden = true
                    self.Errormessage.isHidden = true
                    self.passwardError.isHidden = false                }
                else{
                    self.passwardError.isHidden = true
                    self.EmailError.isHidden = true
                    self.Errormessage.isHidden = false

                }

            }
            else{
                print("login success")
                self.performSegue(withIdentifier: "goToChat", sender: self)
                SVProgressHUD.dismiss()
            }
        })
        //TODO: Log in the user
        
        
    }
    


    
}  
