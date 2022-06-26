//
//  InterfaceElement.swift
//  testPryaniky
//
//  Created by Тоха on 26.06.2022.
//

import Foundation

protocol InterfaceElementData: Decodable {
}

struct InterfaceElement: Decodable {
    let name: InterfaceElements
    let data: InterfaceElementData
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(InterfaceElements.self, forKey: .name)
        debugPrint("parsing \(name)")
        switch name {
        case .text:
            data = try values.decode(TextData.self, forKey: .data)
        case .picture:
            data = try values.decode(PictureData.self, forKey: .data)
        case .selector:
            data = try values.decode(SelectorData.self, forKey: .data)
        }
    }
}

struct TextData: InterfaceElementData {
    let text: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        text = try values.decode(String.self, forKey: .text)
    }
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
    }
}

struct PictureData: InterfaceElementData {
    let url: URL
    let text: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let urlRaw = try values.decode(String.self, forKey: .url)
        guard let urlSafe = URL(string: urlRaw) else {
            url = URL(string: "https://pryaniky.com/static/img/logo-a-512.png")!
            throw NetworkErrors.failedUrl
        }
        url = urlSafe
        text = try values.decode(String.self, forKey: .text)
    }
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case text = "text"
    }
}

struct SelectorData: InterfaceElementData {
    let selectedId: Int
    let variants: [SelectorVariant]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        selectedId = try values.decode(Int.self, forKey: .selectedId)
        variants = try values.decode([SelectorVariant].self, forKey: .variants)
    }
    
    enum CodingKeys: String, CodingKey {
        case selectedId = "selectedId"
        case variants = "variants"
    }
}

struct SelectorVariant: Decodable {
    let id: Int
    let text: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        text = try values.decode(String.self, forKey: .text)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case text = "text"
    }
}
