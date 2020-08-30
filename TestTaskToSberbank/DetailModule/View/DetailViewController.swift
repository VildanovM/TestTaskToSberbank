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
    private let titleLabel = UILabel()
    private let producerLabel = UILabel()
    private let directorLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private var filmImage = UIImageView()
    private let popButton = UIButton()
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenter = presenter else { return }
        presenter.setFilm()
        designDetailView()
        stackViewCustomization()
        setConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let arrayOfLabels = [producerLabel, directorLabel, releaseDateLabel]
        arrayOfLabels.forEach {
            $0.alpha = 0
        }
        UIView.animate(withDuration: 1, animations: {
            arrayOfLabels.forEach {
                $0.alpha = 1
            }
        })
    }
    
    private func designDetailView() {
        view.backgroundColor = .white
        popButton.setTitle("Return to List", for: .normal)
        popButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        popButton.backgroundColor = .black
        popButton.layer.cornerRadius = 10
        popButton.layer.masksToBounds = true
        setShadowToImage()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        producerLabel.numberOfLines = 0
        
        
    }
    
    private func setShadowToImage() {
        filmImage.layer.shadowRadius = 5
        filmImage.layer.shadowOpacity = 0.7
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
        presenter.tap()
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

