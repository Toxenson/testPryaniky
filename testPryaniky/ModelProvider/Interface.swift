//
//  Model.swift
//  testPryaniky
//
//  Created by Тоха on 21.06.2022.
//

import Foundation

struct Interface: Decodable {
    let data: [InterfaceElement]
    let views: [InterfaceElements]
    
    static func mapSelf(_ json: Data) -> Interface? {
        debugPrint("start parsing")
        do {
            let model = try JSONDecoder().decode(Interface.self, from: json)
            debugPrint("json parsed")
            return model
        } catch {
            debugPrint("wrong model")
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        views = try values.decode([InterfaceElements].self, forKey: .views)
        data = try values.decode([InterfaceElement].self, forKey: .data)
    }
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case views = "view"
    }
}

enum InterfaceElements: Decodable {
    case text
    case picture
    case selector
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let element = try? container.decode(String.self)
        switch element {
        case "hz": self = .text
        case "picture": self = .picture
        case "selector": self = .selector
        default:
            self = .text
        }
    }
}
