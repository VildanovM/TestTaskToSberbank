//
//  MainTableViewController.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 29.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import UIKit
import CoreData

final class MainTableViewController: UITableViewController {
    // MARK: - Свойства
    var presenter: MainPresenterProtocol?
    
    lazy var fetchedResultsController: NSFetchedResultsController<Film> = {
        let fetchRequest = NSFetchRequest<Film>(entityName:"Film")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "episodeId", ascending:true)]
        guard let dataProvider = presenter?.dataProvider else { return NSFetchedResultsController() }
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataProvider.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        do {
            try controller.performFetch()
        } catch {
            let nsError = error as NSError
            fatalError("Ошибка \(nsError), \(nsError.userInfo)")
        }
        return controller
    }()
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reusedId)
        tableView.dataSource = self
        tableView.delegate = self
        presenter?.getFilms()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
}

// MARK: - Реализация протокола
extension MainTableViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}

extension MainTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reusedId, for: indexPath) as! TableViewCell
        let film = fetchedResultsController.object(at: indexPath)
        cell.titleName.text = film.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = fetchedResultsController.object(at: indexPath)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let film = StarWars(producer: object.producer, title: object.title, director: object.director, openingCrawl: object.openingCrawl, episodeId: object.episodeId, releaseDate: dateFormatter.string(from: object.releaseDate))
        presenter?.tapOnTheFilm(film: film)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

