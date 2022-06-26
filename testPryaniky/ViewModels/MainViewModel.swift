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
            guard let interface = interface else {
                return
            }
            interfaceElementsSubject.onNext(interface.views)
        }
    }
    private var error: MoyaError? {
        didSet {
            errorSubject.onNext(error)
        }
    }
    private let interfaceService: PryanikyNetworkService = PryanikyNetworkServiceImpl()
    let interfaceElementsSubject = PublishSubject<[InterfaceElements]>()
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
