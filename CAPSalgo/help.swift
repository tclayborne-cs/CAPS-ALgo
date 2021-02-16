//
//  help.swift
//  CAPSalgo
//
//  Created by Thomas Clayborne on 2/16/21.
//  Copyright © 2021 Thomas Clayborne. All rights reserved.
//

import Foundation

class GetCameraLocationList: NSObject {
    func endpointForCameras() -> String {
        return "https://algoapi.caps.ua.edu/v2.0/Cameras"
    }
    
    func allCameras(completionHandler: @escaping (CamList?, Error?) -> Void) {
        let endpoint = endpointForCameras()
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let cameras = try decoder.decode(CamList.self, from: responseData)
                completionHandler(cameras, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    
    func getAllCameras() {
        allCameras { (cameras, error) in
            if let error = error {
                print(error)
                return
            }
            guard let cameras = cameras else {
                print("error getting all cameras: result is null")
                return
            }
            //debugPrint(cameras)
            print(cameras)
        }
    }
    
    enum BackendError: Error {
        case urlError(reason: String)
        case objectSerialization(reason: String)
        case objectDeletion(reason: String)
    }
    
}
