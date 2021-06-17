//
//  MainScreenAssembly.swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//

import UIKit

import Foundation

extension Notification.Name {
	static let updateNotification = Notification.Name("updateNotification")
}

final class MainScreenAssembly {
	func build(user: UserModel, city: CityModel? = nil) -> UIViewController {
		//let configurationReader = AppDelegate.container.resolve(IConfigurationReader.self)!
		guard let noteStorage = AppDelegate.container.resolve(ICityStorage.self) else { return ViewController() }
		//let backupManager = AppDelegate.container.resolve(IBackupManager.self)!

		let router = MainScreenRouter(user: user)
		let presenter = MainScreenPresenter(router: router,
											notesStorage: noteStorage,
											center: NotificationCenter.default,
											user: user,
											noteData: city)
		//let tableAdapter = MainScreenTableAdapter()

		let controller = MainScreenViewController(presenter: presenter)
		router.controller = controller
		return controller
	}
}
