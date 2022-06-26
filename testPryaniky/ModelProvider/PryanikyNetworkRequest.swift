//
//  ModelProvider.swift
//  testPryaniky
//
//  Created by Тоха on 21.06.2022.
//

import Moya

enum PryanikyNetworkRequest {
    case loadModel
}

extension PryanikyNetworkRequest: TargetType {
    var baseURL: URL {
        return URL(string: "https://pryaniky.com/static/json")!
    }
    
    var path: String {
        return "/sample.json"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
