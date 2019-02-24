//
//  profileViewController.swift
//  

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseMessaging
import FirebaseStorage
import Alamofire

class citizenprofileViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var phonenumber: UILabel!
    var newPic : Bool?
    var storageRef: StorageReference!
    var text = ""
    let user_id = Auth.auth().currentUser?.uid
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.layer.borderColor=UIColor.gray.cgColor
        storageRef = Storage.storage().reference()
        print("text1",text)
        phonenumber.text = text
        print("Phone",phonenumber.text as Any)
    }
    @IBAction func save(_ sender: Any) {
        if (name.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Error", message: "Please enter First Name", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
            
      
        else
        {
            guard  let Naming = name.text, !Naming.isEmpty else {
                return
            }
            guard  let Phone = phonenumber.text, !Phone.isEmpty else {
                return
            }
            
            let db = Firestore.firestore()
            let token = Messaging.messaging().fcmToken
            if let user_id = Auth.auth().currentUser?.uid{
                print(" naming\(Naming)")
                print(Phone)
                db.collection("User").document(user_id).setData( [
                    "uid": user_id,
                    "Name": Naming,
                    
                    "Phone":Phone,
                    "App": "Bodha",
                    "Flag": false,
                    "DeviceToken": token as Any,
                    
                    ]) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                        } else {
                            print("Document added with ID: \(user_id)")
                        }
                }
            }
            print("userid\(String(describing: self.user_id!))")
            print("phonenumber\( self.phonenumber.text!)")
            let userid = Auth.auth().currentUser?.uid
            let parameters:Parameters = [
                "authID":userid!,
                "PhoneNumber": self.phonenumber.text!
            ]
            Alamofire.request("https://us-central1-deyapay-192704.cloudfunctions.net/bodhaWallet/post", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON{ response in
                    print(request)
                    print(response)
            }
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Tab") as! Tab
//            self.present(vc,animated: true,completion: nil)
            
        }
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let db = Firestore.firestore()
//        if let photo =  info[UIImagePickerControllerOriginalImage] as?  UIImage
//        {
//            let user_id = Auth.auth().currentUser?.uid
//            image.image = photo
//            let StorageRef = Storage.storage().reference(forURL: "gs://bodha-192606.appspot.com")
//            var data=NSData()
//            data = (UIImageJPEGRepresentation(photo,0.8) as NSData?)!
//            let imagepath="UserProfile/\(user_id!)"
//            let childUserImages = StorageRef.child(imagepath)
//            let metaData = StorageMetadata()
//            metaData.contentType = "image/jpeg"
//            childUserImages.putData(data as Data, metadata: metaData){(metaData,error )in
//                if let error = error{
//                    print(error.localizedDescription)
//                    return
//                }else{
//                    let downloadURL = metaData!.downloadURL()!.absoluteString
//                    db.collection("User").document(user_id!).setData([
//                        "photo url":downloadURL
//                        ], options: SetOptions.merge())
//                }
//            }
//        }
//
//        self.dismiss(animated: true, completion: nil )
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
}
extension UIImageView {
    
    func setRounded3() {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
}



