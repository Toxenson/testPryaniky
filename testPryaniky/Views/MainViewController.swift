//
//  ViewController.swift
//  testPryaniky
//
//  Created by Тоха on 21.06.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Properties
    private let mainView = MainView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMainView()
    }
    
    //MARK: - SetUps
    
    private func setUpMainView() {
        mainView.viewModel = MainViewModel()
        mainView.viewModel?.loadModel()
        view = mainView
    }
}

