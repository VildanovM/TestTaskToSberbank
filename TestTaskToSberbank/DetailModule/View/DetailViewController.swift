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
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    let producerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.alpha = 0
        return label
    }()
    let directorLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        return label
    }()
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0
        return label
    }()
    var filmImage: UIImageView = {
        let image = UIImageView()
        image.alpha = 0
        image.contentMode = .scaleAspectFit
        image.layer.shadowRadius = 5
        image.layer.shadowOpacity = 0.7
        return image
    }()
    
    let stackView = UIStackView()
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Назад", style: .done, target: self, action: #selector(popToBackAction))
        setupView()
        presenter?.configured()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let arrayOfLabels = [producerLabel, directorLabel, releaseDateLabel, filmImage]
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
        [filmImage, titleLabel, producerLabel, directorLabel, releaseDateLabel].forEach { stackView.addArrangedSubview($0)
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
    
    
    @objc func popToBackAction() {
        presenter?.returnToList()
    }
}

// MARK: - Реализация протокола
extension DetailViewController: DetailViewProtocol {
    func setFilm(film: StarWars?) {
        guard let film = film else { return }
        titleLabel.text = film.title
        filmImage.image = UIImage(named: film.title + ".jpg")
        producerLabel.text = "Продюсер: " + film.producer
        directorLabel.text = "Режисер: " + film.director
        releaseDateLabel.text = "Дата выхода: " + film.releaseDate
    }
}

