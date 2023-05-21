//
//  DopplerAPI.swift
//  Doppler Manager
//
//  Created by Amit Samant on 16/06/21.
//

import Foundation
import ElegantAPI

enum DopplerAPI {
    case getSecret(username: String, project: String, config: String)
}

extension DopplerAPI: API {
    //https://api.doppler.com/v3/configs/config/secrets?project=my-secrets&config=dev_test
    var baseURL: URL {
        URL(string: "https://api.doppler.com/v3/configs/config/")!
    }
    
    var path: String {
        switch self {
        case .getSecret:
            return "secrets"
        }
    }
    
    var method: ElegantAPI.Method {
        switch self {
        case .getSecret:
            return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case let .getSecret(_ ,project, config):
            return .requestParameters(parameters: [
                "project": project,
                "config": config
            ], encoding: .URLEncoded)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case let .getSecret(username, _, _):
            let token = "\(username):"
            guard let tokenData = token.data(using: .utf8) else {
                return nil
            }
            let base64Token = tokenData.base64EncodedString()
            return [
                "Authorization": "Basic \(base64Token)"
            ]
        }
    }
    
}
