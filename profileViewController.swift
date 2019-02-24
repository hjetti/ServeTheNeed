//
//  profileViewController.swift
//  Servetheneed
//
//  Created by HARIKA JETTI on 2/24/19.
//  Copyright © 2019 HARIKA JETTI. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseMessaging
import FirebaseStorage
import Alamofire

class profileViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var phonenumber: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    
    
    var newPic : Bool?
    var storageRef: StorageReference!
    var text = ""
    //let user_id = Auth.auth().currentUser?.uid
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func save(_ sender: Any) {
        if (name.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Error", message: "Please enter First Name", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
            
//        else if image == nil
//        {
//            let alertController = UIAlertController(title: "Error", message: "Please select photo", preferredStyle: .alert)
//            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alertController.addAction(defaultAction)
//            present(alertController, animated: true, completion: nil)
//        }
        else
        {
            guard  let Naming = name.text, !Naming.isEmpty else {
                return
            }
            guard  let Phone = phoneNumber.text, !Phone.isEmpty else {
                return
            }
            
            let db = Firestore.firestore()
            let token = Messaging.messaging().fcmToken
//            if let user_id = Auth.auth().currentUser?.uid{
                print(" naming\(Naming)")
                print(Phone)
                db.collection("User").document().setData( [
                    //"uid": user_id,
                    "Name": Naming,
                    "lat": 38.9,
                    "long":-122.2,
                    "Phone":Phone,
                    "Flag": false,
                    "DeviceToken": token as Any,
                    
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID)")
                        }
                }
            
            //print("userid\(String(describing: self.user_id!))")
            print("phonenumber\( self.phoneNumber.text!)")
//            let userid = Auth.auth().currentUser?.uid
//            let parameters:Parameters = [
//                "authID":userid!,
//                "PhoneNumber": self.phoneNumber.text!
//            ]
//            Alamofire.request("https://us-central1-deyapay-192704.cloudfunctions.net/bodhaWallet/post", method: .post, parameters: parameters, encoding: JSONEncoding.default)
//                .responseJSON{ response in
//                    print(request)
//                    print(response)
//            }
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Tab") as! Tab
//            self.present(vc,animated: true,completion: nil)
            
        }
        var preferredStatusBarStyle: UIStatusBarStyle{
            return UIStatusBarStyle.lightContent
        }
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
