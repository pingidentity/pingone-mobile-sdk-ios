//
//  CommunicationManager.swift
//  AuthnAPI
//
//  Copyright © 2020 Ping Identity. All rights reserved.
//
//  See LICENSE.txt for the Ping Authentication licensing information.
//

import Foundation

final class CommunicationManager {
    
    func post(requestParams: RequestParams, headerContentType: String, needUrlEncode: Bool, completionHandler: @escaping (_ response: [String: Any]?, _ error: NSError?) -> Void) {
        
        // Prepare request
        guard let requestUrl =  URL(string: requestParams.urlString) else {
            return
        }
        
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = Identifiers.Post
        
        if let params = requestParams.params {
            if needUrlEncode {
                urlRequest.httpBody = urlEncode(params)
            } else {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                } catch let error as NSError {
                    completionHandler(nil, error)
                }
            }
        }
        
        urlRequest.httpShouldHandleCookies = true
        if let cookies = HTTPCookieStorage.shared.cookies {
            let headersWithCoookies = HTTPCookie.requestHeaderFields(with: cookies)
            urlRequest.allHTTPHeaderFields = headersWithCoookies
        }
        
        urlRequest.allHTTPHeaderFields = [Identifiers.ContentType: headerContentType, Identifiers.headerXSRF: Identifiers.typeTest]

        #if DEBUG

        print("**************************************************")
        print("Sending request: \(requestParams.name ?? "")")
        print("with Url:        \(requestUrl)")
        
        if requestParams.name == Identifiers.PathNameLogin {
            print("with username:     \(requestParams.params?["username"] as? String ?? "")")
        } else {
            print("with params:     \(requestParams.params ?? [:])")
        }
        print("**************************************************")
        
        #endif
        
        // Send request
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                        
            guard let data = data, error == nil else {
                completionHandler(nil, error as NSError?)
                return
            }
                
            let httpResponse = response as! HTTPURLResponse

            if let responseString = String(data: data, encoding: .utf8) {
                print("Response:     \(String(describing: responseString))")
                
                // Cookie handle
                if let url = httpResponse.url,
                    let allHeaderFields = httpResponse.allHeaderFields as? [String: String] {
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: allHeaderFields, for: url)
                    HTTPCookieStorage.shared.setCookies(cookies, for: url, mainDocumentURL: nil)
                }
                
                // Get the json response
                var jsonDictionary: NSDictionary?
                
                do {
                    jsonDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                } catch {
                    print("error parsing httpResponse to json")
                }

                if httpResponse.statusCode == 200 {
                    if jsonDictionary != nil {
                        completionHandler(jsonDictionary as? [String: Any], nil)
                    }
                } else {
                    authenticationState.status = .errorReceived
                    
                    if let code = jsonDictionary?["code"] as? String {
                        let errorType = AuthError.init(rawValue: code)
                        if errorType == .validationError {
                            authenticationState.error = .validationError
                        }
                    }
                    
                    let error = NSError.init(domain: Identifiers.errorDomainPingOne, code: httpResponse.statusCode, userInfo: jsonDictionary as? [String: Any] ?? [:])
                    print("Received error response: \(error.localizedDescription)")
                        completionHandler(nil, error as NSError?)
                }
                
            }
            print("Communication task finished successfully")
        }
        task.resume()
    }
    
    private func urlEncode(_ params: [String: Any]) -> Data {
        let jsonString = params.reduce("") { "\($0)\($1.0)=\($1.1)&" }
        let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false)!
        return jsonData
    }
}
