//
//  MainScreenRouter.swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//

import Foundation
import UIKit

protocol IMainScreenRouter: AnyObject {
	//func createNote()
	func openNote(note: CityModel)
	func shareFile(path: URL)
}

final class MainScreenRouter: IMainScreenRouter {
	weak var controller: UIViewController?
	private let user: UserModel

	init(user: UserModel) {
		self.user = user
	}

//	@objc func createNote() {
//		let controller = DetailScreenAssembly().build(user: self.user)
//		self.controller?.navigationController?.pushViewController(controller, animated: true)
//	}

	func openNote(note: CityModel) {
		let controller = DetailScreenAssembly().build(user: self.user, note: note)
		self.controller?.navigationController?.pushViewController(controller, animated: true)
	}

	func shareFile(path: URL) {
		let activityViewController = UIActivityViewController(activityItems: [path],
															  applicationActivities: nil)
		self.controller?.present(activityViewController, animated: true)
	}
}
