//
//  Request_Factory.swift
//  projet_mobiledev
//
//  Created by user231762 on 1/7/23.
//

import Foundation
import UIKit

protocol RequestFactoryProtocol {
    func createRequest(urlStr: String, requestType: RequestType, params:
                       [String]?) -> URLRequest
    func getScheduleList(callback: @escaping ((errorType: CustomError?,
                                               errorMessage: String?), [Schedule]?) -> Void)
    func getSpeakersList(callback: @escaping ((errorType: CustomError?,
                                               errorMessage: String?), [Speakers]?) -> Void)
}
private let scheduleUrlStr = "https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%93%86%20Schedule"
private let speakersUrlStr = "https://api.airtable.com/v0/appLxCaCuYWnjaSKB/%F0%9F%8E%A4%20Speakers"

class RequestFactory: RequestFactoryProtocol {
    
    var scheduleList: [Schedule]?
    var speakersList: [Speakers]?
    internal func createRequest(urlStr: String, requestType: RequestType,
                                params: [String]?) -> URLRequest {
        var url: URL = URL(string: urlStr)!
        if let params = params {
            var urlParams = urlStr
            for param in params {
                urlParams = urlParams + "/" + param
            }
            print(urlParams)
            url = URL(string: urlParams)!
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 100
        request.httpMethod = requestType.rawValue
        
        let accessToken = "keymaCPSexfxC2hF9"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        return request
        
    }
    
    func getScheduleList(callback: @escaping ((errorType: CustomError?,
                                               errorMessage: String?), [Schedule]?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: createRequest(urlStr: scheduleUrlStr, requestType: .get, params: nil)) {
            (data, response, error)
            in
            if let data = data, error == nil {
                if let responseHttp = response as? HTTPURLResponse {
                    if responseHttp.statusCode == 200 {
                        let decoder = JSONDecoder()
                        if let response = try?decoder.decode(Records.self, from: data) {
                            self.scheduleList = response.records
                            callback((nil, nil), response.records)
                        }
                        else {
                            callback((CustomError.parsingError, "parsing error"), nil)
                        }
                    }
                    else {
                        callback((CustomError.statusCodeError, "status code: \(responseHttp.statusCode)"), nil)
                    }
                }
            }
            else {
                callback((CustomError.requestError,
                          error.debugDescription), nil)
            }
        }
        task.resume()
    }
    
    func getSpeakersList(callback: @escaping ((errorType: CustomError?,
                                               errorMessage: String?), [Speakers]?) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: createRequest(urlStr: speakersUrlStr, requestType: .get, params: nil)) {
            (data, response, error)
            in
            if let data = data, error == nil {
                if let responseHttp = response as? HTTPURLResponse {
                    if responseHttp.statusCode == 200 {
                        let decoder = JSONDecoder()
                        if let response = try?decoder.decode(Records_speakers.self, from: data) {
                            callback((nil, nil), response.records)
                        }
                        else {
                            callback((CustomError.parsingError, "parsing error"), nil)
                        }
                    }
                    else {
                        callback((CustomError.statusCodeError, "status code: \(responseHttp.statusCode)"), nil)
                    }
                }
            }
            else {
                callback((CustomError.requestError,
                          error.debugDescription), nil)
            }
        }
        task.resume()
    }
    
}
