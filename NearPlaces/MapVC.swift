//
//  MapVC.swift
//  NearPlaces
//
//  Created by Trakya14 on 13.05.2025.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapVC: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBAction func locationTapped(_ sender: Any) {
        gotoPlaces()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.settings.compassButton=true
        mapView.isMyLocationEnabled=true
        mapView.settings.myLocationButton=true

        // Do any additional setup after loading the view.
    }
    
    func gotoPlaces(){
        txtSearch.resignFirstResponder()
            let acController = GMSAutocompleteViewController()
            acController.delegate = self
            present(acController, animated: true, completion: nil)
          
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
extension MapVC:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        guard let locValue: CLLocationCoordinate2D=manager.location?.coordinate else{ return}
        print ("locations= \(locValue.latitude) \(locValue.longitude)" )
    //lblLocation.text = "latitude= \(locValue.latitude), longitude = \(locValue.longitude)"
        
        
    }
}
extension MapVC: GMSAutocompleteViewControllerDelegate{
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(String(describing: place.name))")
        dismiss(animated: true, completion: nil)
        self.mapView.clear()
        self.txtSearch.text = place.name
        
        
        let cord2D = CLLocationCoordinate2D(latitude: (place.coordinate.latitude), longitude: (place.coordinate.longitude))
        
        let marker=GMSMarker()
        marker.position=cord2D
        marker.title="Location"
        marker.snippet = place.name
        
        let markerImage = UIImage(named: "icon_offer_pickup_1")!
        let markerView = UIImageView(image:markerImage)
        marker.iconView=markerView
        marker.map=self.mapView
        
        self.mapView.camera=GMSCameraPosition.camera(withTarget: cord2D, zoom: 15)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        
    }
    
    
}
