//
//  MainScreenVc.swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//

import UIKit
import CoreData

final class MainScreenViewController: UIViewController {
	
	private let presenter: MainScreenPresenter
	//private let customView: MainScreenView
	//private let tableAdapter: MainScreenTableAdapter
	
	
	init(presenter: MainScreenPresenter) {
		self.presenter = presenter
		//self.tableAdapter = tableAdapter
		//elf.customView = MainScreenView()
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
//	override func loadView() {
//		self.view = self.customView
//		//self.tableAdapter.tableView = self.customView.tableView
//		//self.tableAdapter.delegate = self.presenter
//	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let screenView = MainScreenTableAdapter(style: .plain)
		self.addChild(screenView)
		screenView.view.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(screenView.view)
		screenView.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
		screenView.view.bottomAnchor.constraint(equalTo:  self.view.bottomAnchor, constant: -10).isActive = true
		screenView.view.leadingAnchor.constraint(equalTo:  self.view.leadingAnchor, constant: 10).isActive = true
		screenView.view.trailingAnchor.constraint(equalTo:  self.view.trailingAnchor, constant: -10).isActive = true
		self.configureNavBar(title: "Lol")
		self.presenter.viewDidLoad(view: screenView)
	}
}

extension MainScreenViewController {
	func showAlert(message: String) {
		let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}

	func configureNavBar(title: String) {
		self.title = title
		let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red,
								   NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]
		let rightBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNote))
		rightBarItem.tintColor = UIColor.red
		
		//leftBarItem.tintColor = UIColor.red
		self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
		self.navigationController?.navigationBar.barTintColor = .secondarySystemBackground
		self.navigationController?.navigationBar.isTranslucent = false
		self.navigationController?.navigationBar.shadowImage = UIImage()
		self.navigationItem.rightBarButtonItem = rightBarItem
		//self.navigationItem.leftBarButtonItem = leftBarItem
	}
}

private extension MainScreenViewController {
	@objc func createNote() {
		//style = UIAlertController.Style
		let ac = UIAlertController(title: "Вводите", message: "ВВод", preferredStyle: .alert)
			ac.addTextField { tf in
				let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
				tf.placeholder = cities.randomElement()
			}
			let search = UIAlertAction(title: "Search", style: .default) { action in
				let textField = ac.textFields?.first
				guard let cityName = textField?.text else { return }
				if cityName != "" {
	//                self.networkWeatherManager.fetchCurrentWeather(forCity: cityName)
					let city = cityName.split(separator: " ").joined(separator: "%20")
					self.presenter.showCity(city: city)
					//self.presenter.saveCity(city: city)
					self.presenter.saveCity(city: city)
				}
			}
			let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
			
			ac.addAction(search)
			ac.addAction(cancel)
			present(ac, animated: true, completion: nil)
		}
	}

//	func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style) {
//		let ac = UIAlertController(title: title, message: message, preferredStyle: style)
//		ac.addTextField { tf in
//			let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
//			tf.placeholder = cities.randomElement()
//		}
//		let search = UIAlertAction(title: "Search", style: .default) { action in
//			let textField = ac.textFields?.first
//			guard let cityName = textField?.text else { return }
//			if cityName != "" {
////                self.networkWeatherManager.fetchCurrentWeather(forCity: cityName)
//				let city = cityName.split(separator: " ").joined(separator: "%20")
//				self.presenter.showCity(city: city)
//			}
//		}
//		let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//		ac.addAction(search)
//		ac.addAction(cancel)
//		present(ac, animated: true, completion: nil)
//	}
	


