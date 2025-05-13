//
//  ViewController.swift
//  NearPlaces
//
//  Created by Trakya14 on 13.05.2025.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    // CLLocationManager nesnesi
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var lblLocation: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        getCurrentLocation()
    }
    
    func getCurrentLocation(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate=self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

}
extension ViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        guard let locValue: CLLocationCoordinate2D=manager.location?.coordinate else{ return}
        print ("locations= \(locValue.latitude) \(locValue.longitude)" )
        lblLocation.text = "latitude= \(locValue.latitude), longitude = \(locValue.longitude)"
    }
}
