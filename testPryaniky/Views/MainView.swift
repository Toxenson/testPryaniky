//
//  PryanikiView.swift
//  testPryaniky
//
//  Created by Тоха on 21.06.2022.
//

import UIKit
import RxSwift

class MainView: UIView, HaveViewModel {
    
    //MARK: - Properties
    
    typealias ViewModel = MainViewModel
    private let bag = DisposeBag()
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            debugPrint("viewModel seted")
            _ = viewModel.interfaceElementsSubject.subscribe(
                { event in
                    switch event {
                    case .next(let views):
                        self.mainTableViewRows = views
                        self.viewModelChanged(viewModel)
                    case .error(_):
                        return
                    case .completed:
                        return
                    }
                }
            ).disposed(by: bag)
        }
    }
    private let mainTableView = UITableView()
    private var mainTableViewRows: [InterfaceCellViewModel] = []
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpMainView()
        setUpMainTableView()
        registerTableViewCells()
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
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.layer.cornerRadius = 16
        addSubview(mainTableView)
    }
    
    private func registerTableViewCells() {
        mainTableView.register(TextTableViewCell.self, forCellReuseIdentifier: TextTableViewCell.cellId)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate(
            [
                mainTableView.topAnchor.constraint(equalTo: topAnchor, constant: safeAreaInsets.top),
                mainTableView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
                mainTableView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
                mainTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -safeAreaInsets.bottom)
            ]
        )
    }
    
    //MARK: - Actions
    
    func viewModelChanged(_ viewModel: ViewModel) {
        debugPrint("changing")
        debugPrint("rows is \(mainTableViewRows)")
        mainTableView.reloadData()
    }
}

//MARK: - Extensions

extension MainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainTableViewRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.cellId) as? TextTableViewCell,
            let cellViewModel = mainTableViewRows[0] as? TextCellViewModel{
            cell.viewModel = cellViewModel
            return cell
        }
        return UITableViewCell()
    }
}
