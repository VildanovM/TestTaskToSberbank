//
//  DetailViewController.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 28.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    // MARK: - Cвойства
    var presenter: DetailViewPresenterProtocol?
    // MARK: - Приватные свойства
    private let stackView = UIStackView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let producerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        return label
    }()
    
    private var filmImage: UIImageView = {
        let image = UIImageView()
        image.layer.shadowRadius = 5
        image.layer.shadowOpacity = 0.7
        return image
    }()
    private let popButton: UIButton = {
        let button = UIButton()
        button.setTitle("Return to List", for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.configured()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let arrayOfLabels = [producerLabel, directorLabel, releaseDateLabel]
        UIView.animate(withDuration: 1, animations: {
            arrayOfLabels.forEach {
                $0.alpha = 1
            }
        })
    }
    
    private func setupView() {
        view.backgroundColor = .white
        stackViewCustomization()
        setConstraint()
    }
    
    private func stackViewCustomization() {
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.preservesSuperviewLayoutMargins = true
        view.addSubview(stackView)
        [filmImage, titleLabel, producerLabel, directorLabel, releaseDateLabel, popButton].forEach { stackView.addArrangedSubview($0)
        }
    }
    
    
    private func setConstraint() {
        [stackView, filmImage].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        filmImage.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    
    @objc func tapButton() {
        guard let presenter = presenter else { return }
        presenter.returnToList()
    }
}

// MARK: - Реализация протокола
extension DetailViewController: DetailViewProtocol {
    func setFilm(film: StarWars?) {
        guard let film = film else { return }
        titleLabel.text = film.title
        filmImage.image = UIImage(named: film.title + ".jpg")
        producerLabel.text = "Producer: " + film.producer
        directorLabel.text = "Director: " + film.director
        releaseDateLabel.text = "Release date: " + film.releaseDate
    }
}

