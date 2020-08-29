//
//  MainTableViewController.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 29.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController {
    
    // MARK: - Public Variables
    public var presenter: MainViewPresenterProtocol!
    
    lazy var fetchedResultsController: NSFetchedResultsController<Film> = {
        let fetchRequest = NSFetchRequest<Film>(entityName:"Film")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "episodeId", ascending:true)]
        guard let dataProvider = presenter.dataProvider else { return NSFetchedResultsController() }
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: dataProvider.viewContext,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
        do {
            try controller.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return controller
    }()
    // MARK: - Private Variables
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reusedId)
        tableView.dataSource = self
        tableView.delegate = self
        presenter.getFilms()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reusedId, for: indexPath)
        let film = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = film.title
        cell.detailTextLabel?.text = film.director
        return cell
    }
    

}


extension MainTableViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        tableView.reloadData()
    }
}

extension MainTableViewController: MainViewProtocol {
    func success() {
        tableView.reloadData()
    }

    func failure(error: Error) {
        print(error.localizedDescription)
    }


}

