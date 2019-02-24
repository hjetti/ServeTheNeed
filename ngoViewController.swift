//
//  ngoViewController.swift
//  Servetheneed
//
//  Created by HARIKA JETTI on 2/24/19.
//  Copyright © 2019 HARIKA JETTI. All rights reserved.
//

import UIKit
import GoogleMaps
import FirebaseFirestore

class ngoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Firestore.firestore().collection("NGO").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    var array: [String] = [document.documentID]
                    print("arra", array)
                    
                    for i in 0..<array.count {
                        let docRef = Firestore.firestore().collection("NGO").document(array[i])
                        
                        docRef.getDocument { (document, error) in
                            if let document = document, document.exists {
                                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                                print("Document data: \(dataDescription)")
                                let lat = document.data()?["lat"]
                                let long = document.data()?["long"]
                                let name = document.data()?["Name"] as? String ?? ""
                                let num = document.data()?["Phone"] as? String ?? ""
                                let camera = GMSCameraPosition.camera(withLatitude: lat as! CLLocationDegrees, longitude: long as! CLLocationDegrees, zoom: 7.0)
                                let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                                self.view = mapView
                                
                                // Creates a marker in the center of the map.
                                let marker = GMSMarker()
                                marker.position = CLLocationCoordinate2D(latitude: lat as! CLLocationDegrees, longitude: long as! CLLocationDegrees)
                                marker.title = name
                                marker.snippet = num
                                marker.map = mapView
                                
                                func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
                                    print("didTapInfoWindowOf")
                                }
                                
                                
                            } else {
                                print("Document does not exist")
                            }
                        }
                    }
                    
                }
            }
        }
        
        // Do any additional setup after loading the view.
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
//extension ngoViewController: GMSMapViewDelegate{
//    /* handles Info Window tap */
//    
//    
//    /* handles Info Window long press */
//    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
//        print("didLongPressInfoWindowOf")
//    }
//    
//    /* set a custom Info Window */
//    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
//        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
//        view.backgroundColor = UIColor.white
//        view.layer.cornerRadius = 6
//        
//        let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.size.width - 16, height: 15))
//        lbl1.text = "Hi there!"
//        view.addSubview(lbl1)
//        
//        let lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: view.frame.size.width - 16, height: 15))
//        lbl2.text = "I am a custom info window."
//        lbl2.font = UIFont.systemFont(ofSize: 14, weight: .light)
//        view.addSubview(lbl2)
//        
//        return view
//    }
//}
