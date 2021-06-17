//
//  DetailScreenRouter.swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//

import UIKit

protocol IDetailScreenRouter: AnyObject {
	func goBack()
}

final class DetailScreenRouter: IDetailScreenRouter {
	weak var controller: UIViewController?

	func goBack() {
		self.controller?.navigationController?.popViewController(animated: true)
	}
}
