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

protocol InterfaceCellViewModel {
    var name: InterfaceElements { get set }
    var data: InterfaceElementData { get set }
}

final class MainViewModel {
    
    private var interface: Interface? {
        didSet {
            guard let interface = interface else {
                return
            }
            configureInterfaceCells(with: interface)
            interfaceElementsSubject.onNext(interfaceCells)
        }
    }
    private var error: MoyaError? {
        didSet {
            errorSubject.onNext(error)
        }
    }
    private let interfaceService: PryanikyNetworkService = PryanikyNetworkServiceImpl()
    private var interfaceCells: [InterfaceCellViewModel] = []
    let interfaceElementsSubject = PublishSubject<[InterfaceCellViewModel]>()
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
    
    private func configureInterfaceCells(with interface: Interface) {
        for element in interface.views {
            guard let elementData = interface.data.first(where: { $0.name == element }) else {
                return
            }
            switch element {
            case .text:
                interfaceCells.append(TextCellViewModel(name: elementData.name, data: elementData.data))
            case .picture:
                interfaceCells.append(PictureCellViewModel(name: elementData.name, data: elementData.data))
            case .selector:
                interfaceCells.append(SelectorCellViewModel(name: elementData.name, data: elementData.data))
            }
        }
    }
}
