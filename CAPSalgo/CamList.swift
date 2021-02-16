//
//  CamList.swift
//  CAPSalgo
//
//  Created by Thomas Clayborne on 2/13/21.
//  Copyright © 2021 Thomas Clayborne. All rights reserved.
//

import Foundation
import MapKit

struct CamList: Decodable {
    enum Category: String, Decodable {
        case swift, combine, debugging, xcode
    }
    var cameras = [Camera]()
    // because the API returns a top-level dictionary containing one array
}

// I know I don't need to technically use all these, it just made it easier for me to reference and test
struct Camera: Decodable {
    var id: Int
    var controlType: String
    var imageSupported: Int
    var imageUrl: String
    var lastUpdate: String
    var organizationId: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var streamUrl: String
    var primaryRoad: String
    var mileMarker: Decimal
    var direction: String
    var crossStreet: String
    var requestCommand: String
    var name: String
    var deviceId: Int
    var accessLevelId: Int
    var archived: Bool
}
