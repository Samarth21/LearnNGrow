//
//  ViewController.swift
//  BarrieTransportServicesApp
//
//  Created by Samarth Patel on 2019-07-24.
//  Copyright © 2019 Samarth Patel. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var driverDetails = DriverDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Barrie:Latitude: 44° 24' 48.00" N
      //  Longitude: -79° 40' 48.70" W

        let barrieLatitude = 44.3894
        let barrieLongitude = -79.6983
        
        let barrieLocation = CLLocationCoordinate2D(latitude: barrieLatitude, longitude: barrieLongitude)
        
        let delta = 0.5
        let span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        
        let region = MKCoordinateRegion(center: barrieLocation, span: span)
        
        mapView.setRegion(region, animated: true)
        
        for driver in driverDetails.phoneNumbers{
            print("show location for \(driver.key)")
        
        
        let random1 = Int.random(in: -10...10)
        let random2 = Int.random(in: -10...10)
        
        let delta1 = 0.007 * Double(random1)
        let delta2 = 0.005 * Double(random2)
        
        let driverLocation = CLLocationCoordinate2D(latitude: barrieLatitude + delta1, longitude: barrieLongitude + delta2)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = driverLocation
        annotation.title = driver.key
        annotation.subtitle = driver.value
        
        mapView.addAnnotation(annotation)
        }
        
        mapView.register(CustomAnnotationCallout.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }


}

class CustomAnnotationCallout : MKMarkerAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?){
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.canShowCallout = true
        
        let callButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        
        callButton.setTitle("Call", for: .normal)
        callButton.setTitleColor(UIColor.blue, for: .normal)
        
        callButton.addTarget(self, action: #selector(CustomAnnotationCallout.callPhoneNumber), for: .touchUpInside)
        
        self.rightCalloutAccessoryView = callButton
    }
    
    @objc func callPhoneNumber(sender: UIButton){
        print("call the driver")
        let driverPhoneNumber = (annotation?.subtitle)!
        
        let urlStirng = "tel://" + driverPhoneNumber!
        
        print(urlStirng)
        
        if let url = URL(string: urlStirng){
            UIApplication.shared.openURL(url)
            
        }else{
            //do nothing
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

