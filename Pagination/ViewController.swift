//
//  ViewController.swift
//  Pagination
//
//  Created by admin on 2.04.2021.
//  Copyright © 2021 esaygiver. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    private let loadingActivityIndicator = UIActivityIndicatorView(style: .medium)
    
    lazy var footballTeams: [String] = [
        "Besiktas", "Galatasaray", "Fenerbahce",
        "Besiktas", "Galatasaray", "Fenerbahce",
        "Besiktas", "Galatasaray", "Fenerbahce",
        "Besiktas", "Galatasaray", "Fenerbahce",
        "Besiktas", "Galatasaray", "Fenerbahce",
        "Besiktas", "Galatasaray", "Fenerbahce",
        "Besiktas", "Galatasaray", "Fenerbahce",
        "Besiktas", "Galatasaray", "Fenerbahce"
    ]
    
    lazy var defaultFootballTeams = [
        "SAMPIYON BJK",
        "BJK", "GS", "FB",
        "BJK", "GS", "FB",
        "BJK", "GS", "FB",
        "BJK", "GS", "FB"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func isLoadingMoreTeams(to loadingStatus: Bool) {
        if loadingStatus {
            loadingActivityIndicator.startAnimating()
            self.footballTeams.append(contentsOf: defaultFootballTeams)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.tableView.reloadData()
            })
        } else {
            loadingActivityIndicator.stopAnimating()
            loadingActivityIndicator.hidesWhenStopped = true
        }
    }
}

//MARK: - TableView Delegate and DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return footballTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaginationCell", for: indexPath)
        cell.textLabel?.text = footballTeams[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        loadingActivityIndicator.center = footerView.center
        footerView.addSubview(loadingActivityIndicator)
        tableView.tableFooterView = footerView
        return footerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == footballTeams.count - 1 {
            isLoadingMoreTeams(to: true)
        } else {
            isLoadingMoreTeams(to: false)
        }
    }
}
