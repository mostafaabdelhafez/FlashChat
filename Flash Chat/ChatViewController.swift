//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
import ChameleonFramework
class ChatViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    var messagearray:[Message]=[Message]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messagearray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "customMessageCell",for:indexPath) as! CustomMessageCell
        cell.messageBody.text!=messagearray[indexPath.row].messagebody
        cell.senderUsername.text!=messagearray[indexPath.row].sender
        cell.avatarImageView.image=UIImage(named:"egg")
        if cell.senderUsername.text! == FIRAuth.auth()?.currentUser?.email as String! {
            cell.messageBackground.backgroundColor=UIColor.flatMint()
            cell.avatarImageView.backgroundColor=UIColor.flatWatermelon()
        }
        else{
            cell.messageBackground.backgroundColor=UIColor.flatRed()
            cell.avatarImageView.backgroundColor=UIColor.flatBlue()

        }
        return cell

    }
    
    
    // Declare instance variables here

    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        messageTableView.delegate=self
        messageTableView.dataSource=self
        messageTableView.register(UINib(nibName:"MessageCell",bundle:nil), forCellReuseIdentifier: "customMessageCell")
        //TODO: Set yourself as the delegate and datasource here:
        messageTextfield.delegate=self
        configuretableview()
        retrievemessage()
        messageTableView.separatorStyle = .none
        //TODO: Set yourself as the delegate of the text field here:

        
        
        //TODO: Set the tapGesture here:
        
        let tapgesture=UITapGestureRecognizer(target: self, action: #selector(tableviewtapped))
        messageTableView.addGestureRecognizer(tapgesture)
        //TODO: Register your MessageCell.xib file here:

        
    }

    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    
    
    
    //TODO: Declare cellForRowAtIndexPath here:
    
    
    
    //TODO: Declare numberOfRowsInSection here:
    
    
    
    //TODO: Declare tableViewTapped here:
    @objc func tableviewtapped(){
        messageTextfield.endEditing(true)
    }
    
    //0224576735
    
    //TODO: Declare configureTableView here:
    func configuretableview(){
        
        messageTableView.rowHeight=UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight=120.0
    }
    
    
    ///////////////////////////////////////////
    
    //MARK:- TextField Delegate Methods
    
    

    
    //TODO: Declare textFieldDidBeginEditing here:
    
    
    func textFieldDidBeginEditing(_ textField:UITextField) {
        
        UIView.animate(withDuration: 0.5, animations: {self.heightConstraint.constant=308
            self.view.layoutIfNeeded()})
    }
    
    //TODO: Declare textFieldDidEndEditing here:
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5, animations: {self.heightConstraint.constant=50.0
            self.view.layoutIfNeeded()})
    }
    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.isEnabled=false
        sendButton.isEnabled=false
       let messagedb=FIRDatabase.database().reference().child("messages")
         let messagedictionary=["sender":FIRAuth.auth()?.currentUser?.email,"messagebody":messageTextfield.text!]
        messagedb.childByAutoId().setValue(messagedictionary){(error,ref)
            in
            if error != nil{
                print(error!)
            }
            else{print("success saved")
                self.messageTextfield.isEnabled=true
                self.sendButton.isEnabled=true
              self.messageTextfield.text!=""
            }
            
        }
        
        
        //TODO: Send the message to Firebase and save it in our database
        
        
    }
    
    //TODO: Create the retrieveMessages method here:
    
    func retrievemessage(){
        
        let messagedb=FIRDatabase.database().reference().child("messages")
        messagedb.observe(.childAdded) { (snapshot) in
         let snapshotvalue=snapshot.value as! Dictionary<String,String>
            let text=snapshotvalue["messagebody"]!
            let sender=snapshotvalue["sender"]!
            let message=Message()
            message.messagebody=text
            message.sender=sender
            self.messagearray.append(message)
            self.configuretableview()
            self.messageTableView.reloadData()
        }
    }

    
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        do{ try FIRAuth.auth()?.signOut()
        }
            catch {print("faild")}
        
      guard(navigationController?.popToRootViewController(animated: true)) != nil
        else{
            
            
            print("view controller doesnt exist")
            return
        }
        //may error is pop because xcode need to make sure that you have vc to pop off because if you in the root already so poping off the root will crash your app and in this case we gona use guard statment so it its not nill ok if not return to the same chat vc
        //TODO: Log out the user and send them back to WelcomeViewController
        
        }

    }
    

