//
//  DetailScreenTableAdapter.swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//


//import UIKit
//import Foundation
//
////protocol IMainScreenTableAdapter: AnyObject {
////	var delegate: MainScreenTableAdapterDelegate? { get set}
////	var tableView: UITableView? { get set}
////	func update(notes: [MainScreenItemViewModel])
////}
////
////protocol MainScreenTableAdapterDelegate: AnyObject {
////	func onItemClick(note: UUID)
////	func onItemDelete(note: UUID)
////}
//
//final class DetailScreenTableAdapter: NSObject {
//	private enum Constants {
//		static let noteCell = "NoteCell"
//	}
//	private var notes = [DetailScreenItemViewModel]()
//	//weak var delegate: MainScreenTableAdapterDelegate?
//	weak var tableView: UITableView? {
//		didSet {
//			self.tableView?.delegate = self
//			self.tableView?.dataSource = self
//			self.tableView?.register(DetailScreenNoteCell.self, forCellReuseIdentifier: Constants.noteCell)
//		}
//	}
//}
//
//extension DetailScreenTableAdapter{
//	func update(day: [MainScreenItemViewModel]) {
//		self.notes = day
//		self.tableView?.reloadData()
//	}
//}
////
////extension DetailScreenTableAdapter: UITableViewDelegate {
////	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////		self.delegate?.onItemClick(note: self.notes[indexPath.row].id)
////	}
////
////	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
////		let deleteAction = UIContextualAction(style: .destructive, title: "Удалить", handler: { (_, _, _) in
////			self.delegate?.onItemDelete(note: self.notes[indexPath.row].id)
////		})
////		deleteAction.backgroundColor = .red
////		return UISwipeActionsConfiguration(actions: [deleteAction])
////	}
////}
//
//extension DetailScreenTableAdapter: UITableViewDataSource, UITableViewDelegate {
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		return self.notes.count
//	}
//
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let note = self.notes[indexPath.row]
//		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.noteCell, for: indexPath)
//		(cell as? MainScreenNoteCell)?.update(vm: note)
//		return cell
//	}
//}
//
//

import Foundation
import UIKit
//
//class DetailScreenTableAdapter: UITableViewController {
//
//	let dayOfWeek =  [("Monday","sun"),( "Tuesday","sun"), ("Wednesday","sun"), ("Thursday","sun"), ("Friday","sun"), ("​Saturday","sun")]
//
//	public var quotesCountHandler: (() -> Int)?
//	public var cellWillShowHandler: ((_ cell: CellViewProtocol, _ index: Int) -> Void)?
//
//	private static let cellId = "CellIdentifier"
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		self.configureView()
//		self.tableView.backgroundColor = .red
//		self.tableView.reloadData()
//	}
//
//	internal func showColors() {
//		self.tableView.reloadData()
//	}
//
//	private func configureView() {
//		self.tableView.contentInset = UIEdgeInsets(top: 14.0, left: 0, bottom: 0, right: 0)
//		//self.tableView.allowsSelection = false
//		self.tableView.register(DetailScreenNoteCell.self, forCellReuseIdentifier: DetailScreenTableAdapter.cellId)
//	}
//	// MARK: - Delegates
//	internal override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////		return self.quotesCountHandler?() ?? 0
//		return 6
//
//	}
//
//	internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//		let identefier = DetailScreenTableAdapter.cellId
//		guard var cell = tableView.dequeueReusableCell(withIdentifier: identefier, for: indexPath) as? DetailScreenNoteCell
//		else {
//			return UITableViewCell()
//		}
//		cell = DetailScreenNoteCell(style: .subtitle, reuseIdentifier: identefier)
//		self.cellWillShowHandler?(cell, indexPath.row)
//		return cell
////		let cell = tableView.dequeueReusableCell(withIdentifier: DetailScreenTableAdapter.cellId, for: indexPath) as! DetailScreenNoteCell
////
////		//let identefier = QuotesScreenView.cellId
////
////		let tag = dayOfWeek[indexPath.row]
////
////		cell.textLabel?.text = "lol"
////		//tagUrl = String?(tag.content) ?? "lox"
////
////		cell.imageView?.image = UIImage(systemName:"tag")
////
////		return cell
//	}
//}
//extension DetailScreenTableAdapter {
//	func update() {
//		self.tableView.reloadData()
//	}
//}

class DetailScreenTableAdapter: UITableView, UITableViewDelegate, UITableViewDataSource {
	
	  let cellId = "ImageCellIdentifier"
	public var cellWillShowHandler: ((_ cell: DetailScreenNoteCell, _ index: Int) -> Void)?
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return 6
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "")
		cell.textLabel?.text = "Hallo"
		//cell.detailTextLabel?.text = "This is \(indexPath.row) cell"
		return cell
//		let identefier = cellId
//		guard let cell = tableView.dequeueReusableCell(withIdentifier: identefier, for: indexPath) as? DetailScreenNoteCell
//		else {
//			return UITableViewCell()
//		}
//		self.cellWillShowHandler?(cell, indexPath.row)
//		return cell
	}


}

