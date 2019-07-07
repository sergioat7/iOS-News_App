//
//  Session.swift
//  NewsApp
//
//  Created by Aragones, Sergio (ES - Madrid) on 06/07/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import Alamofire


class Session: NSObject {
    
    fileprivate static let _sharedSession = Session()
    static func sharedSession() -> Session {
        return _sharedSession
    }
    
    /**************************** Configuración de Alamofire ****************************/
    fileprivate static var _sessionManager: SessionManager?
    var sessionManager: SessionManager? {
        set {
            Session._sessionManager = newValue
        }
        get {
            if Session._sessionManager == nil {
                let sessionManagerAux: SessionManager = Alamofire.SessionManager.default
                let alamofireRetrier = AlamofireRetrier()
                sessionManagerAux.retrier = alamofireRetrier
                sessionManagerAux.adapter = alamofireRetrier
                Session._sessionManager = sessionManagerAux
            }
            return  Session._sessionManager
        }
    }
    /************************** Fin Configuración de Alamofire **************************/
}
