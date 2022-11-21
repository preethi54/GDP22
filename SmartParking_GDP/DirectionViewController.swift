//
//  DirectionViewController.swift
//  SmartParking_GDP
//
//  Created by Jadhav,Preethi Eshwarlal on 11/13/22.
//

import UIKit
import CoreLocation
import GoogleMaps



class DirectionViewController: UIViewController,CLLocationManagerDelegate {

        
    @IBOutlet weak var myMap: GMSMapView!
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self;
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        
        
//        let destinationmarker = GMSMarker()
//        destinationmarker.position = CLLocationCoordinate2D(latitude: 40.355878, longitude: -94.8817866)
//        destinationmarker.title = "Destination"
//        destinationmarker.snippet = "Missouri"
//        destinationmarker.map = myMap
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.requestLocation()
            myMap.isMyLocationEnabled = true
            myMap.settings.myLocationButton = true
//            let originLati = locationManager.location?.coordinate.latitude;
//            let originLongi = locationManager.location?.coordinate.longitude
//            let destinationLati = 40.355878;
//            let destinationLongi = -94.8817866;
//            print("----------",locationManager.location?.coordinate.latitude)

        }else {
            locationManager.requestWhenInUseAuthorization()
        }
        
        // Do any additional setup after loading the view.
    }
           

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            print("---->>> \(locationManager.location?.coordinate.latitude)")

            let usermarker = GMSMarker()
            usermarker.position = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
            usermarker.title = "Your Loc"
            usermarker.snippet = "Missouri"
            //usermarker.icon = UIImage(named: "UserIcon.png")
            usermarker.map = myMap
            myMap.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0), zoom: 8.0, bearing: 0, viewingAngle: 0)

            
            }
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            if #available(iOS 14.0, *) {
                switch manager.authorizationStatus {
                case .authorizedAlways:
                    print("AuthorizedAlways")
                    return
                case .authorizedWhenInUse:
                    print("AuthorizedWhenInUse")
                    return
                case .denied:
                    print("Denied")
                    return
                case .restricted:
                    print("Restricted")
                    locationManager.requestWhenInUseAuthorization()
                case .notDetermined:
                    print("NotDetermined")
                    locationManager.requestWhenInUseAuthorization()
                default:
                    print("NotDetermined")
                    locationManager.requestWhenInUseAuthorization()
                }
            } else {
                // Fallback on earlier versions
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR LOADING MAP \(error)")
    }

}
