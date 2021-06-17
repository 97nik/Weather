//
//  LoginScreenAssembly.swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//
import UIKit

final class LoginScreenAssembly {
	func build() -> UIViewController {
		let userStorage = AppDelegate.container.resolve(IUserStorage.self)!
		let router = LoginScreenRouter()
		let presenter = LoginScreenPresenter(userStorage: userStorage,
											 router: router)
		
		let controller = LoginScreenViewController(presenter: presenter)
		router.controller = controller
		
		return controller
		
	}
}
