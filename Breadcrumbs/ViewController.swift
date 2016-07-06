//
//  ViewController.swift
//  Breadcrumbs
//
//  Created by Nicholas Outram on 20/01/2016.
//  Copyright © 2016 Plymouth University. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    //variables
    var measurement=0
    
    @IBOutlet weak var mapView: MKMapView!
    lazy var locationManager : CLLocationManager = {

        let loc = CLLocationManager()
        
        //Set up location manager with defaults
        loc.desiredAccuracy = kCLLocationAccuracyBest
        loc.distanceFilter = kCLDistanceFilterNone
        loc.delegate = self
        
        //Optimisation of battery
        loc.pausesLocationUpdatesAutomatically = true
        loc.activityType = CLActivityType.Fitness
        loc.allowsBackgroundLocationUpdates = false
        
        return loc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.requestAlwaysAuthorization()
        
        self.locationManager.startUpdatingLocation()
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations
        locations: [CLLocation])
    {
        
        let location = locations.last
        
         print("measurement=\(measurement) \(locations.last!)\n")
        
          measurement += 1
        
        print("update last location")
        
        print("measurement=\(measurement) latitude=\(location!.coordinate.latitude)\n")
        print("measurement=\(measurement) longitude=\(location!.coordinate.longitude)\n")
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == CLAuthorizationStatus.AuthorizedAlways {
            mapView.showsUserLocation = true
            mapView.userTrackingMode = MKUserTrackingMode.Follow
        } else {
            print("Permission Refused")
        }
    }
}

