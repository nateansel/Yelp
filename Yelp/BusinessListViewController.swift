//
//  BusinessListViewController.swift
//  Yelp
//
//  Created by Nathan Ansel on 8/11/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

class BusinessListViewController: UIViewController {
	
	@IBOutlet weak private var tableView: UITableView!
	private let refreshControl = UIRefreshControl()
	private let searchBar = UISearchBar()
	
	var manager = BusinessManager.shared
	
	var businesses: [Business] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.titleView = searchBar
		searchBar.placeholder = "Search"
		searchBar.delegate = self
		navigationController?.navigationBar.backgroundColor = .red
		navigationController?.navigationBar.barTintColor = .red
		
		tableView.dataSource = self
		tableView.refreshControl = refreshControl
		refreshControl.addTarget(self, action: #selector(refreshControlActivated), for: .valueChanged)
		refreshControl.beginRefreshing()
		refreshControlActivated()
	}
	
	@objc
	private func refreshControlActivated() {
		manager.search(
			success: { (results) in
				self.refreshControl.endRefreshing()
				self.businesses = results.businesses
				self.tableView.reloadData()
			}, failure: { (error) in
				self.refreshControl.endRefreshing()
		})
	}
}

extension BusinessListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return businesses.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessTableViewCell", for: indexPath) as! BusinessTableViewCell
		cell.updateInterface(with: businesses[indexPath.row])
		return cell
	}
}

extension BusinessListViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		manager.search(
			for: searchBar.text,
			success: { (results) in
				self.refreshControl.endRefreshing()
				self.businesses = results.businesses
				self.tableView.reloadData()
			}, failure: { (error) in
				self.refreshControl.endRefreshing()
		})
	}
}
