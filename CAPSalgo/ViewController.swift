//
//  ViewController.swift
//  CAPSalgo
//
//  Created by Thomas Clayborne on 2/13/21.
//  Copyright © 2021 Thomas Clayborne. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class ViewController: UIViewController {
    
    // Utilize Location Manager to ask for permission to use GPS
    let locationManager = CLLocationManager()
    
    @IBOutlet private var mapView: MKMapView!
    
    var resultSearchController:UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable as? UISearchResultsUpdating
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        
        // Handle asynchronously with delegates
        locationManager.delegate = self
        
        // opt for less accuracy of user's loc since the focus is the webcams, save battery
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // request location permissions from user
        locationManager.requestWhenInUseAuthorization()
        
        //iOS >=9 one-time location request
        locationManager.requestLocation()
        
        // Set initial location to geographical center of Alabama (adjusted for aspect ratio)
        let initialLocation = CLLocation(latitude: 32.7182, longitude: -86.7023)
        
        // Do any additional setup after loading the view, typically from a nib.
        mapView.centerToLocation(initialLocation)
        
        // Show scale
        // let scale = MKScaleView(mapView: mapView)
        // scale.scaleVisibility = .visible // always visible
        // view.addSubview(scale)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


// implement/group delegate methods

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            print("location:: (location)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}

private extension MKMapView {
    func centerToLocation(
        _ location: CLLocation,
        regionRadius: CLLocationDistance = 500000
        ) {
            let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            //height, width of AL in degrees
            span: MKCoordinateSpan(latitudeDelta: 4.78, longitudeDelta: 2.75))
        setRegion(coordinateRegion, animated: true)
    }
}

extension ViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        //selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let _ = placemark.locality,
            let _ = placemark.administrativeArea {
            annotation.subtitle = "(city) (state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
}
