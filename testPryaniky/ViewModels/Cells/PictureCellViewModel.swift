//
//  PictureCellViewModel.swift
//  testPryaniky
//
//  Created by Тоха on 26.06.2022.
//

import Foundation

final class PictureCellViewModel: InterfaceCellViewModel {
    var name: InterfaceElements
    var data: InterfaceElementData
    
    init(name: InterfaceElements, data: InterfaceElementData) {
        self.name = name
        self.data = data
    }
}
