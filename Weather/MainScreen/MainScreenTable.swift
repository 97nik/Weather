//
//  MainScreenTable.swift
//  Weather
//
//  Created by Никита on 16.06.2021.
//

import Foundation
import UIKit

class MainScreenTableAdapter: UITableViewController {
	
	var activityIndicator = UIActivityIndicatorView()
	
	public var imagesCountHandler: (() -> Int)?
	public var cellWillShowHandler: ((_ cell: MainScreenNoteCell, _ index: Int) -> Void)?
	
	private static let cellId = "ImageCellIdentifier"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureView()
		self.configureActivityIndicator()
		self.tableView.backgroundColor = UIColor.red
	}
	
	internal func showColors() {
		self.tableView.reloadData()
	}
	private func configureActivityIndicator(){
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		activityIndicator.color = .black
		self.view.addSubview(activityIndicator)
		activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}
	
	private func configureView() {
		self.tableView.contentInset = UIEdgeInsets(top: 14.0, left: 0, bottom: 0, right: 0)
		self.tableView.allowsSelection = false
		self.tableView.register(MainScreenNoteCell.self, forCellReuseIdentifier: MainScreenTableAdapter.cellId)
	}
	
	internal override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100.0
	}
	
	internal override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	internal override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.imagesCountHandler?() ?? 0
	}
	
	internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let identefier = MainScreenTableAdapter.cellId
		guard let cell = tableView.dequeueReusableCell(withIdentifier: identefier, for: indexPath) as? MainScreenNoteCell
		else {
			return UITableViewCell()
		}
		self.cellWillShowHandler?(cell, indexPath.row)
		return cell
	}
	func update() {
			self.tableView.reloadData()
			//self.activityIndicator.stopAnimating()
		}
}

//extension SearchImageScreenView: ISearchImageScreenView {
//
//}
