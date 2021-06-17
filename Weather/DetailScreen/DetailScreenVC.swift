//
//  DetailScreenVC.swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//
import Foundation
import UIKit
import CoreData

protocol IDetailScreenViewController: AnyObject {
	func configureNavBar(button: String)
	func showAlert(message: String)
}


final class DetailScreenViewController: UIViewController {
	private let presenter: IDetailScreenPresenter
	private let customView: NoteScreenView
	//fix
	private let tab: DetailScreenTableAdapter

	init(presenter: IDetailScreenPresenter) {
		self.presenter = presenter
		self.customView = NoteScreenView()
		self.tab = DetailScreenTableAdapter()
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		self.view = customView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.presenter.viewDidLoad(uiView: self.customView,
								   controller: self, tab: tab)
	}
}

extension DetailScreenViewController: IDetailScreenViewController {
	func configureNavBar(button: String) {
		let rightBarButton = UIBarButtonItem(title: button,
											 style: .done,
											 target: self,
											 action: #selector(self.saveNote))
		self.navigationItem.rightBarButtonItem = rightBarButton
		self.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
	}

	func showAlert(message: String) {
		let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}

	@objc func saveNote() {
		self.presenter.saveNote()
	}
}

