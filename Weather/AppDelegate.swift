//
//  AppDelegate.swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//

import UIKit
import CoreData
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	static let container = Container()
	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		AppDelegate.initDependences()
		self.window = UIWindow(frame: UIScreen.main.bounds)
		let controller = LoginScreenAssembly().build()
		let navigationVC = UINavigationController(rootViewController: controller)
		self.window?.rootViewController = navigationVC
		self.window?.makeKeyAndVisible()
		self.window?.overrideUserInterfaceStyle = .light
		return true
	}
	
	static func initDependences() {
		let storage = CoreDataStorage()
				AppDelegate.container.register(ICityStorage.self) { _ in
					return storage
				}
		.inObjectScope(.container)
		AppDelegate.container.register(IUserStorage.self) { _ in
			return storage
		}
		.inObjectScope(.container)
		
	}
}
