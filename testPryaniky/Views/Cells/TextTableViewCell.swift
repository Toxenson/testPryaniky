//
//  TextTableViewCell.swift
//  testPryaniky
//
//  Created by Тоха on 26.06.2022.
//

import UIKit
import RxSwift

class TextTableViewCell: UITableViewCell {
    //MARK: - Properties
    
    static let cellId = String(describing: TextTableViewCell.self)
    private let bag = DisposeBag()
    var viewModel: TextCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            _ = viewModel.textDataSubject.subscribe(
                { event in
                    switch event {
                    case .next(let text):
                        guard let text = text else {
                            return
                        }
                        self.mainTextLabel.text = text
                    case .error(_):
                        return
                    case .completed:
                        return
                    }
                }
            ).disposed(by: bag)
        }
    }
    private let mainTextLabel = UILabel()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTextLabel()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    override func layoutSubviews() {
        activateConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - SetUps
    
    private func setupTextLabel() {
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = .gray.withAlphaComponent(0.2)
        mainTextLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainTextLabel)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate(
            [
                mainTextLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                mainTextLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ]
        )
    }
    
    //MARK: - Actions
}
