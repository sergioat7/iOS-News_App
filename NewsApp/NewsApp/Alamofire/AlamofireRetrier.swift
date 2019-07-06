//
//  AlamofireRetrier.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 06/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Alamofire


class AlamofireRetrier: RequestRetrier, RequestAdapter {
    
    private typealias RefreshCompletion = (_ succeeded: Bool, _ token: String?) -> Void
    
    private let lock = NSLock()
    
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    
    
    init() {}
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        
        if error.localizedDescription == "cancelado" || error.localizedDescription == "cancelled" {
            completion(false, 0.0)
        }
        else if let response = request.task?.response as? HTTPURLResponse {
            print("Status code: \(response.statusCode)")
            switch response.statusCode {
                
            case 200...299: //Respuesta correcta
                completion(false, 0.0)
                
            default: //Error general
                showErrorViewController()
                completion(false, 0.0)
            }
        }
        else {
            showErrorViewController()
            completion(false, 0.0)
        }
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        return urlRequest
    }
    
    private func showErrorViewController(){
        let errorController = ErrorController()
        DispatchQueue.main.async {
            AppDelegate.sharedAppDelegate().setRootViewController(errorController)
        }
    }
}
