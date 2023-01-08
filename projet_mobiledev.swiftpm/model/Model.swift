//
//  Model.swift
//  projet_mobiledev
//
//  Created by user231762 on 1/7/23.
//

import Foundation
import UIKit

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

struct Schedule_speaker: Codable {
    let id: String
    let activity: String
    let activity_type: String
    let start: String
    let end: String
    let location: String
    let speakers: String
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

enum RequestType: String {
    case get = "GET"
}
enum CustomError: Error {
    case requestError
    case statusCodeError
    case parsingError
}
