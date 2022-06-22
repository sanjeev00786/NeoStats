//
//  FeedModel.swift
//  NeoStats
//
//  Created by Sanjeev Mehta on 22/06/22.
//

import SwiftyJSON

class FeedModel {

    var nearEarthObjects: NearEarthObjects?
    var links: Links?
    var elementCount: Int?

    init(_ json: JSON) {
        nearEarthObjects = NearEarthObjects(json["near_earth_objects"])
        links = Links(json["links"])
        elementCount = json["element_count"].intValue
    }

}

class NearEarthObjects {

    var firstObject: [Object]?
    var secondObject: [Object]?

    init(_ json: JSON) {
        firstObject = json["2020-06-20"].arrayValue.map { Object($0) }
        secondObject = json["2020-06-21"].arrayValue.map { Object($0) }
    }

}

class Object {

    var closeApproachData: [CloseApproachData]?
    var name: String?
    var absoluteMagnitudeH: Double?
    var neoReferenceId: String?
    var isSentryObject: Bool?
    var links: Links?
    var isPotentiallyHazardousAsteroid: Bool?
    var nasaJplUrl: String?
    var estimatedDiameter: EstimatedDiameter?
    var id: String?

    init(_ json: JSON) {
        closeApproachData = json["close_approach_data"].arrayValue.map { CloseApproachData($0) }
        name = json["name"].stringValue
        absoluteMagnitudeH = json["absolute_magnitude_h"].doubleValue
        neoReferenceId = json["neo_reference_id"].stringValue
        isSentryObject = json["is_sentry_object"].boolValue
        links = Links(json["links"])
        isPotentiallyHazardousAsteroid = json["is_potentially_hazardous_asteroid"].boolValue
        nasaJplUrl = json["nasa_jpl_url"].stringValue
        estimatedDiameter = EstimatedDiameter(json["estimated_diameter"])
        id = json["id"].stringValue
    }

}

class CloseApproachData {

    var missDistance: MissDistance?
    var relativeVelocity: RelativeVelocity?
    var epochDateCloseApproach: Int?
    var orbitingBody: String?
    var closeApproachDateFull: String?
    var closeApproachDate: String?

    init(_ json: JSON) {
        missDistance = MissDistance(json["miss_distance"])
        relativeVelocity = RelativeVelocity(json["relative_velocity"])
        epochDateCloseApproach = json["epoch_date_close_approach"].intValue
        orbitingBody = json["orbiting_body"].stringValue
        closeApproachDateFull = json["close_approach_date_full"].stringValue
        closeApproachDate = json["close_approach_date"].stringValue
    }

}

class MissDistance {

    var astronomical: String?
    var miles: String?
    var kilometers: String?
    var lunar: String?

    init(_ json: JSON) {
        astronomical = json["astronomical"].stringValue
        miles = json["miles"].stringValue
        kilometers = json["kilometers"].stringValue
        lunar = json["lunar"].stringValue
    }

}

class RelativeVelocity {

    var kilometersPerSecond: String?
    var kilometersPerHour: String?
    var milesPerHour: String?

    init(_ json: JSON) {
        kilometersPerSecond = json["kilometers_per_second"].stringValue
        kilometersPerHour = json["kilometers_per_hour"].stringValue
        milesPerHour = json["miles_per_hour"].stringValue
    }

}

class Links {

    var selfField: String?

    init(_ json: JSON) {
        selfField = json["self"].stringValue
    }

}

class EstimatedDiameter {

    var miles: Miles?
    var meters: Meters?
    var feet: Feet?
    var kilometers: Kilometers?

    init(_ json: JSON) {
        miles = Miles(json["miles"])
        meters = Meters(json["meters"])
        feet = Feet(json["feet"])
        kilometers = Kilometers(json["kilometers"])
    }

}

class Miles {

    var estimatedDiameterMin: Double?
    var estimatedDiameterMax: Double?

    init(_ json: JSON) {
        estimatedDiameterMin = json["estimated_diameter_min"].doubleValue
        estimatedDiameterMax = json["estimated_diameter_max"].doubleValue
    }

}

class Meters {

    var estimatedDiameterMin: Double?
    var estimatedDiameterMax: Double?

    init(_ json: JSON) {
        estimatedDiameterMin = json["estimated_diameter_min"].doubleValue
        estimatedDiameterMax = json["estimated_diameter_max"].doubleValue
    }

}

class Feet {

    var estimatedDiameterMin: Double?
    var estimatedDiameterMax: Double?

    init(_ json: JSON) {
        estimatedDiameterMin = json["estimated_diameter_min"].doubleValue
        estimatedDiameterMax = json["estimated_diameter_max"].doubleValue
    }

}

class Kilometers {

    var estimatedDiameterMin: Double?
    var estimatedDiameterMax: Double?

    init(_ json: JSON) {
        estimatedDiameterMin = json["estimated_diameter_min"].doubleValue
        estimatedDiameterMax = json["estimated_diameter_max"].doubleValue
    }

}
