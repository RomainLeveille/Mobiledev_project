import Foundation
import UIKit
// Model
struct Records: Codable {
    let records: [Schedule]?
}

struct Records_speakers: Codable {
    let records: [Speakers]?
}
struct Schedule: Codable {
    let id: String
    let fields: Fields
}

struct Speakers: Codable {
    let id: String
    let fields: Fields_speakers
}


struct Fields: Codable {
    let activity: String
    let activity_type: String?
    let start: String
    let end: String
    let location: String
    let speakers: [String]?
    enum CodingKeys: String, CodingKey {
        case activity = "Activity"
        case activity_type = "Type"
        case start = "Start"
        case end = "End"
        case location = "Location"
        case speakers = "Speaker(s)"
    }
}

struct Fields_speakers: Codable {
    let name: String
    let company: String
    let role: String
    let email: String
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case company = "Company"
        case role = "Role"
        case email = "Email"
    }
}
/*
struct Response: Codable {
    let id: String
    let deleted: Bool
}
struct ErrorResponse: Codable {
    let error: String
}*/
enum RequestType: String {
    case get = "GET"
}
enum CustomError: Error {
    case requestError
    case statusCodeError
    case parsingError
}
// Request Factory
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
                        /*let dateFormatter = DateFormatter()
                        dateFormatter.timeZone = TimeZone.current
                        dateFormatter.locale = Locale(identifier: "fr-FR-POSIX")
                        dateFormatter.dateFormat = "d/M/yyyy HH:mma"
                        decoder.dateDecodingStrategy = .formatted(dateFormatter)*/
                        if let response = try?decoder.decode(Records.self, from: data) {
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
                        /*let dateFormatter = DateFormatter()
                        dateFormatter.timeZone = TimeZone.current
                        dateFormatter.locale = Locale(identifier: "fr-FR-POSIX")
                        dateFormatter.dateFormat = "d/M/yyyy HH:mma"
                        decoder.dateDecodingStrategy = .formatted(dateFormatter)*/
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
// Controller

let requestFactory = RequestFactory()

requestFactory.getScheduleList { (errorHandle, schedules) in
    if let _ = errorHandle.errorType, let errorMessage =
        errorHandle.errorMessage {
        print("test")
        print(errorMessage)
    }
    else if let list = schedules, let _ = list.last {
        /*for i in list {
            print(i.fields.activity)
        }*/
        
        print(list[7].fields.activity)
        print(list[7].fields.activity_type)
        print(list[7].fields.start)
        print(list[7].fields.location)
        print(list[0].fields.speakers![1])
        //print(schedule.id)
    }
    else {
        print("Houston we got a problem")
    }
}

requestFactory.getSpeakersList { (errorHandle, speakers) in
    if let _ = errorHandle.errorType, let errorMessage =
        errorHandle.errorMessage {
        print("test")
        print(errorMessage)
    }
    else if let list = speakers, let speaker = list.last {
        print(list[7].fields.name)
        print(list[7].fields.company)
        print(speaker.id)
    }
    else {
        print("Houston we got a problem")
    }
}

        




