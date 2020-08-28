//
//  ViewController.swift
//  TestTaskToSberbank
//
//  Created by Максим Вильданов on 28.08.2020.
//  Copyright © 2020 Максим Вильданов. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Public Variables
    public var presenter: MainViewPresenterProtocol!
    // MARK: - Private Variables
    private let networkTableview = UITableView()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .black
        networkTableview.backgroundColor = .black
        let safeAreaView = view.safeAreaLayoutGuide
        networkTableview.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reusedId)
        view.addSubview(networkTableview)
        networkTableview.dataSource = self
        networkTableview.delegate = self
        
        networkTableview.translatesAutoresizingMaskIntoConstraints = false
        networkTableview.topAnchor.constraint(equalTo: safeAreaView.topAnchor).isActive = true
        networkTableview.bottomAnchor.constraint(equalTo: safeAreaView.bottomAnchor).isActive = true
        networkTableview.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor).isActive = true
        networkTableview.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor).isActive = true
        
        
    }


}

extension MainViewController: MainViewProtocol {
    func success() {
        networkTableview.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let day = presenter.comments?[indexPath.row]
        presenter.tapOnTheComment(comment: day)
    }
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reusedId, for: indexPath)
        let comment = presenter.comments?[indexPath.row]
        cell.textLabel?.text = comment?.body
        
        return cell
    }
       
}

