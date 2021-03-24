//
//  PatientBaseData.swift
//  RelaxNow
//
//  Created by Pritrum on 11/03/21.
//

import Foundation

struct PatientBaseData : Codable {
    let status : Int?
    let message : String?
    let patients : [PatientData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case patients = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        patients = try values.decodeIfPresent([PatientData].self, forKey: .patients)
    }

}
