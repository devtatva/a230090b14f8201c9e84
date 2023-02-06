//
//  APIManger.swift
//  builderTest
//
//  Created by pcq186 on 06/02/23.
//

import Foundation
import Alamofire

class APIManager {
    
    static var shared: APIManager = APIManager()
    
    func sendRequest<T:Codable>(_ route: Router, type: T.Type, successCompletion: @escaping(_ response: T) -> Void, failureCompletion: @escaping(_ error: Error) -> Void) {
        
        let path = route.path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        var parameter = route.parameters
        if route.parameters == nil || route.parameters?.count == 0 {
            parameter = [:]
        }
        
        var encoding : ParameterEncoding = JSONEncoding.default
        
        if route.methods == .get {
            encoding = URLEncoding.default
        }
        
        AF.request(path!, method: route.methods,
                parameters: parameter!,
                encoding: encoding,
                headers: nil
        ).responseData { response in
            if response.response?.statusCode == 200 {
                if let data = response.data {
                    do {
                        let resp = try JSONDecoder().decode(type.self, from: data)
                        successCompletion(resp)
                    } catch {
                        let error = NSError(domain: "JSON_DECODING_FAILUER", code: 200, userInfo: nil)
                        failureCompletion(error)
                    }
                }
            } else {
                let error = NSError(domain: "API_RESPONSE_FAILURE", code: response.response?.statusCode ?? 400, userInfo: nil)
                failureCompletion(error)
            }
        }
    }
}
