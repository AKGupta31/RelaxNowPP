//
//  UserData.swift
//  RelaxNow
//
//  Created on 08/03/21.
//

import Foundation
struct UserData : Codable {
    // MARK: - Singleton
    
    private static var _current: UserData?

    static var current: UserData {
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        return currentUser
    }
    
    static func setCurrent(_ user: UserData) {
        _current = user
    }
    static func clearCurrent(){
        _current = nil
    }

    
    let userId : Int?
    let firstName : String?
    let lastName : String?
    let email : String?
    let gender : String?
    let mobile : String?
    let role : String?
    let token : String?

    enum CodingKeys: String, CodingKey {

        case userId = "USERID"
        case firstName = "FIRSTNAME"
        case lastName = "LASTNAME"
        case email = "EMAIL"
        case gender = "GENDER"
        case mobile = "MOBILE"
        case role = "ROLE"
        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        role = try values.decodeIfPresent(String.self, forKey: .role)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }


    
}
