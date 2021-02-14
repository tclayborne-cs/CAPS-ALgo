//
//  CamList.swift
//  CAPSalgo
//
//  Created by Thomas Clayborne on 2/13/21.
//  Copyright © 2021 Thomas Clayborne. All rights reserved.
//

import Foundation

struct CamList: Decodable {
    enum Category: String, Decodable {
        case swift, combine, debugging, xcode
    }
    
    // I know I don't need to actually document all these, it just made it easier for me to reference
    
    let id: Int?
    let controlType: String?
    let imageSupported: Int
    let imageURL: String?
    let lastUpdate: String?
    let organizationId: String?
    let latitude: Int?
    let longitude: Int?
    let streamUrl: String?
    let primaryRoad: String?
    let mileMarker: Int?
    let direction: String?
    let crossStreet: String?
    let requestCommand: String?
    let name: String?
    let deviceId: Int?
    let accessLevelId: Int?
    let archived: Bool?
}
