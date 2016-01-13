//
//  ViewController.swift
//  Regiontest
//
//  Created by Timothy Andres (i7679245) on 29/10/2015.
//  Copyright © 2015 Timbology. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
    
    let locationManager = CLLocationManager ()
    var photos = [Photo]()
    
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var myImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//parameters: ["api_key": "b9c95abe84903005ea81ed25c63fbc8a"]
        
        

        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        
        myMap.setUserTrackingMode(.Follow, animated: true)
        
        
        let bournemouthGardens = CLLocationCoordinate2D (latitude: 50.719799, longitude: -1.879439)
        
        let bournemouthGardensRegion = CLCircularRegion(center: bournemouthGardens, radius: 50, identifier: "bournemouthgardens")
        
        locationManager.startMonitoringForRegion(bournemouthGardensRegion)
        
        let bournemouthPier = CLLocationCoordinate2D (latitude: 50.716098, longitude: -1.875780)
        
        let bournemouthPierRegion = CLCircularRegion(center: bournemouthPier, radius: 50, identifier: "bournemouth")
        
        locationManager.startMonitoringForRegion(bournemouthPierRegion)
        
        let boscombePier = CLLocationCoordinate2D (latitude: 50.719914, longitude: -1.843552)
        
        let boscombePierRegion = CLCircularRegion(center: boscombePier, radius: 50, identifier: "boscombe")
        
        locationManager.startMonitoringForRegion(boscombePierRegion)
        
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowPhotos" {
            
            let vc = segue.destinationViewController as! PhotosViewController
            vc.photos = photos
            
        }
    }
    

}


extension ViewController: CLLocationManagerDelegate {
    
        func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
            print (region.identifier)

            Alamofire.request(.GET, "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=206dcb0ade4879da809339697bb014e3&tags=bournemouth+beach&lat=50.719799&lon=-1.879439&format=json&nojsoncallback=1&api_sig=b4360599befadb62ee07be31575245fb" ).response { request, response, data, error in
                    if let data = data {
                    let json = JSON(data:data)
                    
                    self.photos.removeAll()
                     
                    for photoJSON in json["photos"]["photo"].arrayValue {
                        let photo = Photo(info: photoJSON)
                        self.photos.append(photo)
                    }
                    
                    print(self.photos.count)
                    
                }
            }
             
        }
    }
