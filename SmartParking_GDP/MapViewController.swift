//
//  MapViewController.swift
//  SmartParking_GDP
//
//  Created by Jadhav,Preethi Eshwarlal on 11/5/22.
//

import UIKit
import GoogleMaps
import Foundation
import MapKit
import CoreLocation
//import Firebase

struct Location : Decodable {
    var lotId : Int
    var lotNumber : String
    var latitude : Double
    var longitude : Double
    var lotName : String
}

class MapViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate{

    
    var name = "";
    var vechileNumber = "";
    var yourArray = [Location]()
    var markers = [GMSMarker()]
    //var locations = [Location(lotId : 1 ,lotNumber :"22",latitude: 40.35111, longitude: -94.88253,lotName : "ColdenHall")]
    var locations = [Location(lotId :1 ,lotNumber :"22",latitude: 40.35111, longitude: -94.88253,lotName : "ColdenHall"), Location(lotId:2,lotNumber:"22",latitude:40.35308,longitude:-94.88895,lotName:"Valk Building"),
        Location(lotId:3,lotNumber:"23",latitude:40.35798,longitude:-94.89086,lotName:"BD Owens Library"),
        Location(lotId:4,lotNumber:"24",latitude:40.35379,longitude:-94.88341,lotName:"Student Union")]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchParkingLots()
        
        
        // Do any additional setup after loading the view.
        let camera = GMSCameraPosition.camera(withLatitude: locations[0].latitude, longitude: locations[0].longitude, zoom: 14.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.delegate = self;
        self.view.addSubview(mapView)
        for location in locations{
            let marker = GMSMarker()
            let lati  = location.latitude
            let longi = location.longitude
            //let a = (lati as NSString).doubleValue
           // let b = (longi as NSString).doubleValue
            marker.position = CLLocationCoordinate2D(latitude: lati, longitude: longi)
            marker.title = location.lotName
            marker.snippet = "Missouri"
            marker.map = mapView
            markers.append(marker)
        }
    }
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("didTap marker \(marker.title) \(marker.position)")

        // remove color from currently selected marker
        if let selectedMarker = mapView.selectedMarker {
            selectedMarker.icon = GMSMarker.markerImage(with: nil)
        }
        // select new marker and make green
        mapView.selectedMarker = marker
        marker.icon = GMSMarker.markerImage(with: UIColor.green)
        // tap event handled by delegate
        
        let originLati = 40.355834;
        let originLongi = -94.8845524;
        let destinationLati = marker.position.latitude;
        let destinationLongi = marker.position.longitude;
    
        self.navigateOnGoogleMap(sourceLatitude: originLati, sourceLongitude: originLongi, destinationLatitude: destinationLati, destinationLongitude: destinationLongi)
        return true
    }
    
    func fetchParkingLots() {
        let getParkingLots = "http://10.31.102.148:7073/api/SlotBooking/get-parking-lots";
        guard let url = URL(string: getParkingLots) else{
                return
            }
        let task = URLSession.shared.dataTask(with: url){ [self]
                data, response, error in
                let decoder = JSONDecoder()
                if let data = data{
                    do{
                        locations = try! JSONDecoder().decode([Location].self, from: data)
                        print("-----",locations)
                    }
                }
            }
            task.resume()
    }

    func navigateToMap(){
//        let coordinate = CLLocationCoordinate2DMake((locations[0].longitude),(locations[0].latitude))
//        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
//        mapItem.name = "Target location"
//        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        
 
    }
    
    func navigateOnGoogleMap(sourceLatitude : Double, sourceLongitude : Double, destinationLatitude : Double, destinationLongitude : Double) {
        let urlGoogleMap : URL = URL(string: "comgooglemaps://?saddr=\(sourceLatitude),\(sourceLongitude)&daddr=\(destinationLatitude),\(destinationLongitude)&directionsmode=driving")!
        
        if UIApplication.shared.canOpenURL(urlGoogleMap) {
            UIApplication.shared.open(urlGoogleMap, options: [:], completionHandler: nil)
            
        } else {
            let urlString = URL(string:"http://maps.google.com/?saddr=\(sourceLatitude),\(sourceLongitude)&daddr=\(destinationLatitude),\(destinationLongitude)&directionsmode=driving")
            
            UIApplication.shared.open(urlString!, options: [:], completionHandler: nil)
        }
    }

}
