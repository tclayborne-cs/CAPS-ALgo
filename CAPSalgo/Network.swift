//
//  Network.swift
//  CAPSalgo
//
//  Created by Thomas Clayborne on 2/13/21.
//  Copyright © 2021 Thomas Clayborne. All rights reserved.
//

import Foundation

class Network {
    func getCams(completionHandler: @escaping ([CamList]) -> Void) {
        let url = URL(string: "https://algoapi.caps.ua.edu/v2.0/Cameras")!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error fetching camera list: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(HTTPURLResponse.)
                else {
                    print("Response error, status code not expected: \(String(describing: response))")
                    return
            }
            if let data = data,
                let camSummmary = try? JSONDecoder().decode(self, from: data) {
                completionHandler(camSummmary.results ?? [])
            }
        })
        task.resume()
    }
}
