//
//  ModelProvider.swift
//  testPryaniky
//
//  Created by Тоха on 21.06.2022.
//

import Moya

enum PryanikyNetworkRequest {
    case loadModel
    case loadPicture(path: String)
}

extension PryanikyNetworkRequest: TargetType {
    var baseURL: URL {
        return URL(string: "https://pryaniky.com/static")!
    }
    
    var path: String {
        switch self {
        case .loadModel:
            return "/json/sample.json"
        case .loadPicture(let path):
            return "/img/" + path
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loadModel:
            return .get
        case .loadPicture(_):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .loadModel:
            return .requestPlain
        case .loadPicture(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
