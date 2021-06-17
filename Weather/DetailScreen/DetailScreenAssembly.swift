//
//  DetailScreenAssembly.swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//

import UIKit

final class DetailScreenAssembly {
	func build(user: UserModel, note: CityModel? = nil) -> UIViewController {
		let noteStorage = AppDelegate.container.resolve(ICityStorage.self)!
		let router = DetailScreenRouter()
		let presenter = DetailScreenPresenter(router: router,
											noteStorage: noteStorage,
											center: NotificationCenter.default, user: user,
											noteData: note)
		let controller = DetailScreenViewController(presenter: presenter)
		router.controller = controller
		return controller
	}
}
