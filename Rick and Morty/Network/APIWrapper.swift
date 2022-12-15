//
//  APIWrapper.swift
//  Rick and Morty
//
//  Created by Applanding Solutions on 2022-12-13.
//

import Foundation
import Alamofire

class APIWrapper: NSObject {
    
    // Get API Wrapper method to call APIs
    class func requestGetUrl<T:Decodable>(_ apiUrl : String, params : [String : Any] = [:], success:@escaping (_ response:T) -> Void, failure:@escaping (_ error:Error,_ responseData:Data?) -> Void){
        
        //Alamofire request method
        AF.request(apiUrl, method: .get, parameters:params).validate()
            .responseDecodable(of: T.self) { response in
                //Response with success and failure block
                switch response.result {
                case .success(let value):
                    success(value)
                case .failure(let error):
                    failure(error,response.data)
                }
            }
    }
}
