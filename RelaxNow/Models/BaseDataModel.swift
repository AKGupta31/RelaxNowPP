//
//  BaseDataModel.swift
//  RelaxNow
//
//  Created by Pritrum on 10/03/21.
//

import Foundation

struct BaseDataModel : Codable {
    let status : Int?
    let message : String?
    let userData : UserData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case userData = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userData = try values.decodeIfPresent(UserData.self, forKey: .userData)
    }

}
