//
//  MainViewModel.swift
//  testPryaniky
//
//  Created by Тоха on 21.06.2022.
//

import RxSwift
import Moya



protocol HaveViewModel: AnyObject {
    associatedtype ViewModel

    var viewModel: ViewModel? { get set }
    func viewModelChanged(_ viewModel: ViewModel)
}

final class MainViewModel {
    
    private var interface: Interface? {
        didSet {
            interfaceSubject.onNext(interface)
        }
    }
    private var error: MoyaError? {
        didSet {
            errorSubject.onNext(error)
        }
    }
    private let interfaceService: PryanikyNetworkService = PryanikyNetworkServiceImpl()
    let interfaceSubject = PublishSubject<Interface?>()
    let errorSubject = PublishSubject<MoyaError?>()
    
    func loadModel() {
        interfaceService.getInterface { interface, error in
            if let interface = interface {
                self.interface = interface
            }
            
            if let error = error {
                self.error = error
            }
        }
    }
}
