//
//  TextCellViewModel.swift
//  testPryaniky
//
//  Created by Тоха on 26.06.2022.
//

import Foundation
import RxSwift

final class TextCellViewModel: InterfaceCellViewModel {
    var name: InterfaceElements
    var data: InterfaceElementData {
        didSet {
            guard let textData = data as? TextData else {
                return
            }
            
            textDataSubject.onNext(textData.text)
        }
    }
    let textDataSubject = BehaviorSubject<String?>(value: nil)
    
    init(name: InterfaceElements, data: InterfaceElementData) {
        self.name = name
        self.data = data
        guard let textData = data as? TextData else {
            return
        }
        textDataSubject.onNext(textData.text)
    }
}
