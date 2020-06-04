//
//  NetworkController.swift
//  Luvit-challenge
//
//  Created by Fernando Martin Garcia Del Angel on 03/06/20.
//  Copyright © 2020 Fernando Martin Garcia Del Angel. All rights reserved.
//

import UIKit

class NetworkController {
    // MARK: - Properties
    private static var sharedNC : NetworkController = {
        let nc = NetworkController()
        return nc
    }()
    
    // MARK: - Initializers
    
    // MARK: - Accessors
    class func shared() -> NetworkController {
        return sharedNC
    }
    
    // MARK: - Methods
    
    private func downloadImage(from url: URL, completion: @escaping (UIImage) -> ()){
        guard UIApplication.shared.canOpenURL(url) else {
            self.logger(message: "URL is invalid.")
            completion(UIImage())
            return
        }
        
        getData(from: url) { (data, response, error) in
            guard error != nil else {
                self.logger(message: error?.localizedDescription ?? "Unknown")
                completion(UIImage())
                return
            }
            
            guard let data = data else {
                self.logger(message: "Data is empty or nil.")
                completion(UIImage())
                return
            }
            
            guard let image = UIImage(data: data) else {
                self.logger(message: "Data downloaded is not of image type.")
                completion(UIImage())
                return
            }
            
            completion(image)
            
        }
        
    }
    
    func downloadImage(from string: String, completion: @escaping (UIImage) -> ()) {
        guard let url = URL(string: string),
            UIApplication.shared.canOpenURL(url) else {
                self.logger(message: "URL string is invalid.")
                completion(UIImage())
                return
        }
        
        downloadImage(from: url) { (image) in
            completion(image)
        }
    }
    
    // MARK: - Helper Methods
    
    private func getData(from url: URL, completion: @escaping (Data?,URLResponse?,Error?) -> ()) {
        URLSession.shared.dataTask(with: url,completionHandler: completion).resume()
    }
}

// MARK: - Helper Protocols
extension NetworkController : LoggableClass {
    func logger(message: String) {
        print("[Network Controller] - \(message)")
    }
    
    
}
