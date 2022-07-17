//
//  Models.swift
//  RocketsList
//
//  Created by Nadezhda Zenkova on 13.09.2021.
//

import Foundation

public struct Rocket: Codable {
    public let id: String?
    public let active: Bool?
    public let stages: Int?
    public let boosters: Int?
    public let costPerLaunch: Double?
    public let successRatePct: Double?
    public let firstLaunch: String?
    public let country: String?
    public let company: String?
    public let height: Height?
    public let diameter: Diameter?
    public let mass: Mass?
    public let firstStage: FirstStage?
    public let secondStage: SecondStage?
    public let engines: Engines?
    public let landingLegs: LandingLegs?
    public let flickrImages: [URL]?
    public let wikipedia: URL?
    public let rocketDescription: String?
    public let rocketID: String?
    public let rocketName: String?
    public let rocketType: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case active = "active"
        case stages = "stages"
        case boosters = "boosters"
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstLaunch = "first_flight"
        case country = "country"
        case company = "company"
        case height = "height"
        case diameter = "diameter"
        case mass = "mass"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case engines = "engines"
        case landingLegs = "landing_legs"
        case flickrImages = "flickr_images"
        case wikipedia = "wikipedia"
        case rocketDescription = "description"
        case rocketID = "rocket_id"
        case rocketName = "name"
        case rocketType = "rocket_type"
    }
}

public struct Height: Codable {
    public let meters: Double?
}

public struct Diameter: Codable {
    public let meters: Double?
}

public struct Mass: Codable {
    public let kg: Int?
}

public struct Thrust: Codable {
    public let kN: Int?
}

public struct FirstStage: Codable {
    public let reusable: Bool?
    public let enginesAmount: Int?
    public let fuelAmountTons: Double?
    public let burningTime: Int?
    public let thrustSeaLevel: Thrust?
    public let thrustVacuum: Thrust?
    
    enum CodingKeys: String, CodingKey {
        case reusable = "reusable"
        case enginesAmount = "engines"
        case fuelAmountTons = "fuel_amount_tons"
        case burningTime = "burn_time_sec"
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
    }
}

public struct SecondStage: Codable {
    public let reusable: Bool?
    public let enginesAmount: Int?
    public let fuelAmountTons: Double?
    public let burningTime: Int?
    public let thrust: Thrust?
    
    enum CodingKeys: String, CodingKey {
        case reusable = "reusable"
        case enginesAmount = "engines"
        case fuelAmountTons = "fuel_amount_tons"
        case burningTime = "burn_time_sec"
        case thrust = "thrust"
    }
}

public struct Engines: Codable {
    public let amount: Int?
    public let type: String?
    public let version: String?
    public let layout: String?
    public let propellant1: String?
    public let propellant2: String?
    public let thrustSeaLevel: Thrust?
    public let thrustVacuum: Thrust?
    
    enum CodingKeys: String, CodingKey {
        case amount = "number"
        case type = "type"
        case version = "version"
        case layout = "layout"
        case propellant1 = "propellant_1"
        case propellant2 = "propellant_2"
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
    }
}

public struct LandingLegs: Codable {
    public let number: Int?
    public let material: String?
}



public struct Launch: Codable {
    public let flightNumber: Int?
    public let name: String?
    public let id: String?
    public let launchYear: String?
    public let launchDateUnix: Int?
    public let launchDateUTC: String?
    public let launchDateLocal: String?
    public let tbd: Bool?//
    public let rocketID: String?
    public let launchSuccess: Bool?
    public let links: Links?
    public let description: String?
    public let upcoming: Bool?
    public let staticFireDateUTC: String?
    public let staticFireDateUnix: Int?
    
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case name = "name"
        case id = "id"
        case launchYear = "launch_year"
        case launchDateUnix = "date_unix"
        case launchDateUTC = "date_utc"
        case launchDateLocal = "date_local"
        case tbd = "tbd"
        case rocketID = "rocket"
        case launchSuccess = "launch_success"
        case links = "links"
        case description = "details"
        case upcoming = "upcoming"
        case staticFireDateUTC = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
    }
}

public struct Launchpad: Codable {
    public let images: Images?
    public let id: String?
    public let status: String?
    public let name: String?
    public let fullName: String?
    public let locality: String?
    public let region: String?
    public let timezone: String?
    public let latitude, longitude: Double?
    public let launchAttempts: Int?
    public let launchSuccesses: Int?
    public let rockets: [String]?
    public let launches: [String]?
    public let description: String?

  public enum CodingKeys: String, CodingKey {
    case images, name
    case fullName = "full_name"
    case locality, region, timezone, latitude, longitude
    case launchAttempts = "launch_attempts"
    case launchSuccesses = "launch_successes"
    case rockets, launches, status, id
    case description = "details"
    }
}

public struct Images: Codable {
    public let large: [URL]?
}

public struct Links: Codable {
    public let patch: Patch?
    public let reddit: Reddit?
    public let flickr: Flickr?
    public let presskit: URL?
    public let webcast: URL?
    public let youtube: URL?
    public let article: URL?
    public let wikipedia: URL?
    
    func hasAnyValues() -> Bool {
        var patchHasValues = false
        var redditHasValues = false
        var flickrHasValues = false
        if let patchInstance = patch, patchInstance.hasAnyValues() {
            patchHasValues = true
        }
        if let redditInstance = reddit, redditInstance.hasAnyValues() {
            redditHasValues = true
        }
        if let flickrInstance = flickr, flickrInstance.hasAnyValues() {
            flickrHasValues = true
        }
        
        if patchHasValues || redditHasValues || flickrHasValues || presskit != nil || webcast != nil || youtube != nil || article != nil || wikipedia != nil {
            return true
        } else {
            return false
        }
    }

public enum CodingKeys: String, CodingKey {
    case patch = "patch"
    case reddit = "reddit"
    case flickr = "flickr"
    case presskit = "presskit"
    case webcast = "webcast"
    case youtube = "youtube_id"
    case article = "article"
    case wikipedia = "wikipedia"
    }
}

public struct Patch: Codable {
    public let small: URL?
    public let large: URL?
    
    func hasAnyValues() -> Bool {
        return small != nil || large != nil
    }
}

public struct Reddit: Codable {
    public let compaign: URL?
    public let launch: URL?
    public let media: URL?
    public let recovery: URL?
    
    func hasAnyValues() -> Bool {
        return compaign != nil || launch != nil || media != nil || recovery != nil
    }
}

public struct Flickr: Codable {
    public let small: [URL]?
    public let original: [URL]?
    
    func hasAnyValues() -> Bool {
        return small != nil || original != nil
    }
}

extension Encodable {
  var dictionary: KeyValuePairs<String, Any>? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? KeyValuePairs<String, Any> }
  }
}
