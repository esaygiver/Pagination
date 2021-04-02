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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityIndicatorHeight: NSLayoutConstraint!
    
    lazy var footballTeams: [String] = [
        "Besiktas", "Galatasaray", "Fenerbahce",
        "Besiktas", "Galatasaray", "Fenerbahce",
        "Besiktas", "Galatasaray", "Fenerbahce",
        "Besiktas", "Galatasaray", "Fenerbahce",
        "Besiktas", "Galatasaray", "Fenerbahce"
    ]
    
    lazy var defaultFootballTeams = [
        "SAMPIYON BESIKTAS",
        "BJK", "GS", "FB",
        "BJK", "GS", "FB",
        "BJK", "GS", "FB",
        "BJK", "GS", "FB"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDelegations()
    }
    
    func setUpDelegations() {
        tableView.delegate = self
        tableView.dataSource = self
        activityIndicator.isHidden = true
        activityIndicatorHeight.constant = 0
    }
    
    func isLoading(to loading: Bool) {
        if loading {
            activityIndicator.isHidden = false
            activityIndicatorHeight.constant = 20
            activityIndicator.startAnimating()
            self.footballTeams.append(contentsOf: defaultFootballTeams)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.hidesWhenStopped = true
                self.activityIndicatorHeight.constant = 0
                self.tableView.reloadData()
            })
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == footballTeams.count - 1 {
            isLoading(to: true)
        }
    }
    
}
