//
//  CameraLocation.swift
//  CAPSalgo
//
//  Created by Thomas Clayborne on 2/16/21.
//  Copyright © 2021 Thomas Clayborne. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class CameraLocation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    init(name: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        title = name
        coordinate = CLLocationCoordinate2DMake(latitude, longitude)
    }
    
}
