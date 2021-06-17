//
//  DetailScreenPresenter.swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//

import Foundation

protocol IDetailScreenPresenter: AnyObject {
	func viewDidLoad(uiView: INoteScreenView, controller: IDetailScreenViewController, tab: DetailScreenTableAdapter)
	func saveNote()
}

final class DetailScreenPresenter {
	private weak var uiView: INoteScreenView?
	private weak var controller: IDetailScreenViewController?
	private weak var tab: DetailScreenTableAdapter?
	private let router: IDetailScreenRouter
	private let noteStorage: ICityStorage
	private let center: NotificationCenter
	private let user: UserModel
	private var noteData: CityModel?
	private var colorPresenters = [DetailScreenCellPresenter]()
	init(router: IDetailScreenRouter, noteStorage: ICityStorage, center: NotificationCenter, user: UserModel, noteData: CityModel? = nil) {
		self.router = router
		self.noteStorage = noteStorage
		self.center = center
		self.user = user
		self.noteData = noteData
	}
}

extension DetailScreenPresenter: IDetailScreenPresenter {
	func viewDidLoad(uiView: INoteScreenView, controller: IDetailScreenViewController, tab: DetailScreenTableAdapter) {
		self.uiView = uiView
		self.controller = controller
		self.tab = tab
		self.displayNote()
	}

	func saveNote() {
		if let originalText = self.uiView?.noteText,
		   originalText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
			let lines = originalText.split(separator: "\n")
			let name = String(lines.first ?? "")
			//let name = originalText.replacingOccurrences(of: title, with: "", options: .literal, range: nil)
			self.saveNoteInStorage(name: name)
		}
	}

	func saveNoteInStorage(name: String) {
		if self.isEditMode, let noteData = self.noteData {
			noteData.update(name: name)
			self.noteStorage.update(note: noteData, completion: { _ in
				self.center.post(name: Notification.Name.updateNotification, object: nil)
				self.router.goBack()
			})
		} else {
			let city = CityModel(holder: self.user.uid, name: name)
			self.noteStorage.create(city: city, completion: { error in
				if error == nil {
					self.center.post(name: Notification.Name.updateNotification, object: nil)
					self.router.goBack()
				} else {
					self.controller?.showAlert(message: "Ошибка создания записи")
				}
			})
		}
	}
}

private extension DetailScreenPresenter {
	var isEditMode: Bool {
		return self.noteData != nil
	}

	func displayNote() {
		self.controller?.configureNavBar(button: self.isEditMode ? "Сохранить" : "Создать")
		self.uiView?.update(DetailScreenItemViewModel(isEditMode: self.noteData != nil,
												name: self.noteData?.name ?? ""))
		self.tab?.cellWillShowHandler = { [weak self] cell, index in
			self?.cellWillShow(cell, at: index)
			
			self?.showColors()
		}
	}
	private func cellWillShow(_ cell: DetailScreenNoteCell, at index: Int) {
		guard index >= 0 , index < 6 else {
			assert(true, "wrong index")
			return
		}

		
		let colorPresenter = self.colorPresenters[index]
		colorPresenter.didLoadView(view: cell)
	}
	private func showColors() {
		self.colorPresenters = []

		guard let rawColors = noteData else { return print("lol") }
		let presenter = DetailScreenCellPresenter(city: rawColors)
		self.colorPresenters.append(presenter)
	//			self.colorPresenters.append(presenter)
//		for rawColor in rawColors {
//			let presenter = ColorCellPresenter(color: rawColor)
//			self.colorPresenters.append(presenter)
//		}
		//self.uiView?.updatee()
	}
}
//
//struct NoteScreenViewModel {
//	let isEditMode: Bool
//	let title: String
//	let mainText: String
//}
