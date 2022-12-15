//
//  Utils.swift
//  Rick and Morty
//
//  Created by Applanding Solutions on 2022-12-14.
//

import Foundation
import KRProgressHUD

class Utils: NSObject {
   static func getLocalizedString(for key:String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    static func showErrorMessage(message:String) {
        KRProgressHUD.showError(withMessage: message)
    }
}
