//
//  DetailViewController.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 28.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let descriptionLabel = UILabel()
    private let popButon = UIButton()
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.setComment()
        let safeArea =  view.safeAreaLayoutGuide
        descriptionLabel.numberOfLines = 0
        popButon.setTitle("pop", for: .normal)
        popButon.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        popButon.backgroundColor = .red
        view.addSubview(popButon)
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        
        popButon.translatesAutoresizingMaskIntoConstraints = false
        popButon.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor).isActive = true
        popButon.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor).isActive = true
        popButon.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -30).isActive = true
        
        
        
    }
    
    @objc func tapButton() {
        presenter.tap()
    }
    
}

extension DetailViewController: DetailViewProtocol {
    func setComment(comment: Comment?) {
        descriptionLabel.text = comment?.body
    }
}
