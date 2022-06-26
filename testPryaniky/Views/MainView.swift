//
//  PryanikiView.swift
//  testPryaniky
//
//  Created by Тоха on 21.06.2022.
//

import UIKit

class MainView: UIView, HaveViewModel {
    
    //MARK: - Properties
    typealias ViewModel = MainViewModel
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            debugPrint("viewModel seted")
            _ = viewModel.subject.subscribe { event in
                self.viewModelChanged(viewModel)
            }
        }
    }
    private let mainTableView = UITableView()
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpMainView()
        setUpMainTableView()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func layoutSubviews() {
        activateConstraints()
    }
    
    //MARK: - SetUps
    
    private func setUpMainView() {
        backgroundColor = .gray
    }
    
    private func setUpMainTableView() {
        mainTableView.layer.cornerRadius = 16
        addSubview(mainTableView)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate(
            [
                mainTableView.topAnchor.constraint(equalTo: topAnchor, constant: safeAreaInsets.top),
                mainTableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
                mainTableView.rightAnchor.constraint(equalTo: rightAnchor, constant: 16),
                mainTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: safeAreaInsets.bottom)
            ]
        )
    }
    
    //MARK: - Actions
    func viewModelChanged(_ viewModel: ViewModel) {
        print("changing")
    }
}

//MARK: - Extensions

extension MainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model = viewModel?.subject.subscribe(<#T##observer: ObserverType##ObserverType#>)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
