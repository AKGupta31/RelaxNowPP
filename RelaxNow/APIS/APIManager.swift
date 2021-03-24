//
//  APIManager.swift
//  RelaxNow
//
//  Created on 10/03/21.
//

import Foundation
import Alamofire
class ErrorObject: Codable {
    
    let message: String
    let key: String?
    
}
struct AlertMessage {
    var title = "Constants.defaultAlertTitle.localized()"
    var body = "Constants.defaultAlertMessage.localized()"
    
}
protocol EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    var version: String { get }
    
}

enum EndpointItem {
    
    static let kBaseUrl = "https://noworrynotension.com/NodeTest/"
    
    // MARK: User actions
    case login
    case profile
    case doctorAppointments//DOCTOR_APPOINTMENTS
    case medicineList
    //    case updateUser
    //    case userExists(_: String)
    
    
}

// MARK: - Extensions
// MARK: - EndPointType
extension EndpointItem: EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String {
        switch APIManager.networkEnviroment {
        case .dev: return EndpointItem.kBaseUrl
        case .production: return  EndpointItem.kBaseUrl
        case .stage: return  EndpointItem.kBaseUrl
        }
    }
    
    var version: String {
        return "/v0_1"
    }
    
    var path: String {
        switch self {
        case .login : return "login/obj"
        case .profile: return "user/profile"
        case .doctorAppointments: return "api/executequery"
        case .medicineList: return "api/executequery"
        //        case .updateUser:
        //            return "user/update"
        //        case .userExists(let email):
        //            return "/user/check/\(email)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login,.doctorAppointments,.medicineList:
            return .post
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .login :
            return ["Content-Type": "application/json"]
        case .profile,.doctorAppointments,.medicineList:
            return ["Content-Type": "application/json",
                    "token": UserData.current.token!]
        default:
            return ["Content-Type": "application/json",
                    "X-Requested-With": "XMLHttpRequest"]
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
}

enum NetworkEnvironment {
    case dev
    case production
    case stage
}


class APIManager {
    
    // MARK: - Vars & Lets
    
    private let sessionManager: SessionManager
    static let networkEnviroment: NetworkEnvironment = .dev
    
    // MARK: - Vars & Lets
    
    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager(sessionManager: SessionManager())
        
        return apiManager
    }()
    
    // MARK: - Accessors
    
    class func shared() -> APIManager {
        return sharedApiManager
    }
    
    // MARK: - Initialization
    
    private init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    
    func callMethod<T>(type: EndpointItem, params: Parameters? = nil, handler: @escaping (T?, _ error: AlertMessage?)->()) where T: Codable {
        
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseJSON { data in
                                        switch data.result {
                                        case .success(_):
                                            let decoder = JSONDecoder()
                                            if let jsonData = data.data {
                                                
                                                let result = try! decoder.decode(T.self, from: jsonData)
                                                handler(result, nil)
                                            }
                                            break
                                        case .failure(_):
                                            handler(nil, self.parseApiError(data: data.data))
                                            break
                                        }
                                    }
    }
    
    private func parseApiError(data: Data?) -> AlertMessage {
        let decoder = JSONDecoder()
        if let jsonData = data, let error = try? decoder.decode(ErrorObject.self, from: jsonData) {
            return AlertMessage(title: "Error", body: error.key?.localizedLowercase ?? "Error message")
        }
        return AlertMessage(title: "Error", body: "Error message")
    }
    
    
    func call(type: EndpointItem, params: Parameters? = nil, handler: @escaping (()?, _ error: AlertMessage?)->()) {
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseJSON { data in
                                        switch data.result {
                                        case .success(_):
                                            handler((), nil)
                                            break
                                        case .failure(_):
                                            handler(nil, self.parseApiError(data: data.data))
                                            break
                                        }
                                    }
    }
    
    /*func checkIfUserExists(email: String, handler: @escaping (_ exists: AddEmail.UserExists?, _ message: AlertMessage?)->()) {
     self.apiManager.call(type: RequestItemsType.userExists(email)) { (exists: AddEmail.UserExists?, message: AlertMessage?) in
     if var exists = exists {
     exists.email = email
     handler(exists, nil)
     } else {
     handler(nil, message!)
     }
     }
     }
     func getProfile(handler: @escaping (_ user: User?, _ error: AlertMessage?)->()) {
     self.apiManager.call(type: RequestItemsType.profile) { (user: User?, message: AlertMessage?) in
     if var user = user {
     handler(user, nil)
     } else {
     handler(nil, message!)
     }
     }
     }*/
    
    
    func loginUserWith(_ mobileNo: String,_ password: String, complition: @escaping (_ exists: UserData?, _ message: AlertMessage?)->()){
        let parameter:Parameters = ["query":"call RN_SP_GetUserByMobile('\(mobileNo)','\(password)')",
                                    "params":""]
        self.callMethod(type: .login, params: parameter) { (user: BaseDataModel?, alert) in
            complition(user?.userData,alert)
        }
    }
    
    func listOfAppointments(_ doctorId: String,_ date: String, complition: @escaping (_ patients: [PatientData]?, _ message: AlertMessage?)->()){
        let parameter:Parameters = ["query":"CALL RN_DOCTOR_APPOINTMENTS('\(doctorId)','\(date)')",
                                    "params":""]
        self.callMethod(type: .doctorAppointments, params: parameter) { (appointment: PatientBaseData?, alert) in
            complition(appointment?.patients,alert)
        }
    }
    
    func listOfPatientss(_ doctorId: String,_ date: String, complition: @escaping (_ patients: [PatientData]?, _ message: AlertMessage?)->()){
        let parameter:Parameters = ["query":"call RN_DOCTOR_PATIENTS('\(doctorId)','\(date)')",
                                    "params":""]
        self.callMethod(type: .doctorAppointments, params: parameter) { (appointment: PatientBaseData?, alert) in
            complition(appointment?.patients,alert)
        }
    }
    
    func getListOfMedicines(complition: @escaping (_ response: MedicinelistResponse?, _ message: AlertMessage?)->()){
        let parameter:Parameters = ["query":"Call RN_GET_MEDICINE()",
                                    "params":""]
        self.callMethod(type: .medicineList, params: parameter) { (medicineResponse: MedicinelistResponse?, alert) in
            complition(medicineResponse,alert)
        }
    }
    
}
