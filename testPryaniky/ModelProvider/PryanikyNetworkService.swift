//
//  PryanikiNetworkЫукмшсу.swift
//  testPryaniky
//
//  Created by Тоха on 26.06.2022.
//

import Moya

protocol PryanikyNetworkService {
    func getInterface(_ completition: @escaping (Interface?, MoyaError?) -> ())
}

final class PryanikyNetworkServiceImpl: PryanikyNetworkService {
        
    private let interfaceProvider = MoyaProvider<PryanikyNetworkRequest>()
    
    func getInterface(_ completition: @escaping (Interface?, MoyaError?) -> ()) {
        let callbackMainThread: (Interface?, MoyaError?) -> () = { interface, error in
            DispatchQueue.main.async {
                completition(interface, error)
            }
        }
        interfaceProvider.request(.loadModel) { result in
            switch result {
            case let .success(response):
                let interface = Interface.mapSelf(response.data)
                callbackMainThread(interface, nil)
            case let .failure(error):
                callbackMainThread(nil, error)
            }
        }
    }
}
