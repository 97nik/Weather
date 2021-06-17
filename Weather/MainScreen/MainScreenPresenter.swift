//
//  MainScreenPresenter.swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//

import Foundation
//
//protocol IMainScreenPresenter: MainScreenTableAdapterDelegate {
//	func viewDidLoad(adapter: IMainScreenTableAdapter, controller: IMainScreenController)
//	func createNote()
//	func makeBackup()
//}
struct Model {
let id: UUID
	let holder: UUID
let name: String

}



final class MainScreenPresenter {
	private weak var adapter: MainScreenTableAdapter?
	private weak var adapterr: MainScreenTableAdapter?
	private weak var controller: MainScreenViewController?
	private let router: IMainScreenRouter
	private let notesStorage: ICityStorage
	private let center: NotificationCenter
	//private let configurationReader: IConfigurationReader
	//private let backupManager: IBackupManager
	private let user: UserModel
	private var noteData: CityModel?
	private var notes: [CityModel] = []
	private var model: [Model] = []
	private var city: [String] = []
	private var networkService = NetworkService()
	private var mainScreenCellPresenter = [MainScreenCellPresenter]()
	init(router: IMainScreenRouter, notesStorage: ICityStorage, center: NotificationCenter, user: UserModel, noteData: CityModel? = nil) {
		self.router = router
		self.notesStorage = notesStorage
		//self.configurationReader = configurationReader
		self.center = center
		//self.backupManager = backupManager
		self.user = user
		self.noteData = noteData
//		self.center.addObserver(self, selector: #selector(reloadNotes),
//								name: Notification.Name.updateNotification,
//								object: nil)
	}
	
	deinit {
		self.center.removeObserver(self)
	}
	
	private let timeFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm:ss"
		return formatter
	}()
	
	//	func lol() {
	//		let lil = CityModel(uid: UUID, holder: UUID, date: <#T##Date#>, name: <#T##String?#>)
	//		self.notes.append(lil)
	//	}
}

extension MainScreenPresenter {
	func viewDidLoad(view: MainScreenTableAdapter) {
		self.adapter = view
		//self.notesStorage.deleteAll()
//		self.controller = controller
//		self.controller?.configureNavBar(title: "Погода")
		
		
		self.adapter?.imagesCountHandler = { [weak self] in
			return self?.imagesCount() ?? 0
		}
		self.adapter?.cellWillShowHandler = { [weak self] cell, index in
			self?.cellWillShow(cell, at: index)
		}
		self.displayNotes()
		for citys in city {
			//print(city)
			showCity(city: citys)
			//print(city)
		}
	}
	
	private func imagesCount() -> Int {
		return self.mainScreenCellPresenter.count
	}
	func saveCity(city: String) {
	
		
		let city = CityModel(holder: self.user.uid, name: city)
		print("--")
		print(city.holder)
		print(city.uid)
		print(city.date)
		print(city.name)
		print("--")
		self.notesStorage.create(city: city, completion: { error in
				if error == nil {
					//self.center.post(name: Notification.Name.updateNotification, object: nil)
					//self.router.goBack()
					print("GoBack")
				} else {
					self.controller?.showAlert(message: "Ошибка создания записи")
					print("Ошибка создания записи")
				}
			})
		//sleep(5)
		do {

			self.notes = try self.notesStorage.getNotes(for: self.user)
			model = self.notes.map{
				//showCity(city: $0.name)
				//city.append($0.name)
				Model(id: $0.uid, holder: $0.holder, name: $0.name)
				
			}
	
			//print(city)
			print("tut")
			print(model)
			//print(notes)
			print("tut")
		} catch {
			self.controller?.showAlert(message: "Ошибка загрузки данных")
			self.notes = []
	//	}
	}

		
	}
	private func cellWillShow(_ cell: MainScreenNoteCell, at index: Int) {
		guard index >= 0 , index < 100 else {
			assert(true, "wrong index")
			return
		}
		do {
	
			self.notes = try self.notesStorage.getNotes(for: self.user)
		} catch {
			self.controller?.showAlert(message: "Ошибка загрузки данных")
			self.notes = []
		}
		
//		self.notes.map{
//			let presenter = MainScreenCellPresenter(cityModel: notes.map)
//			self.mainScreenCellPresenter.append(presenter)
//		}
//		let presenter = MainScreenCellPresenter(cityModel: notes.map)
//		self.mainScreenCellPresenter.append(presenter)
//		print(city)
		let imagePresenter = self.mainScreenCellPresenter[index]
		imagePresenter.didLoadView(view: cell)
	}
	
	func showCity(city:String?) {
		guard let url = city else {return}
		self.networkService.performRequest(withURLString: url) {  reslut in
			switch reslut {
			case .success(let webModel):
				DispatchQueue.main.async {
					let presenter = MainScreenCellPresenter(cityModel: webModel)
					self.mainScreenCellPresenter.append(presenter)
					self.adapter?.update()
					//print(webModel)
					print(self.mainScreenCellPresenter)
				}
				case .failure(let error):
				//self.view?.activityIndicator.stopAnimating()
				if !(url.isEmpty) {
					//let alert = AlertController()
					print(error)
					//alert.showAlert(title: "Error", message: "Что-то пошло не так")
				}
			}
		}
	}
	func parseJson(city:String?) {
		
	}
}
	
	




//
//extension MainScreenPresenter: MainScreenTableAdapterDelegate {
//	func onItemDelete(note: UUID) {
//		guard let note = self.notes.first(where: { $0.uid == note }) else { return }
//		self.notesStorage.remove(note: note) { [weak self] error in
//			if error != nil {
//				self?.controller?.showAlert(message: "Ошибка удаления")
//			} else {
//				//self?.reloadNotes()
//			}
//		}
//	}
//
//	func onItemClick(note: UUID) {
//		guard let note = self.notes.first(where: { $0.uid == note }) else { return }
//		self.router.openNote(note: note)
//	}
//}

private extension MainScreenPresenter {
	




func displayNotes() {
	//showCity(city: "kirov")
	defer {
		let model = self.notes.map { Model(id: $0.uid, holder: $0.holder, name: $0.name) }
	
		print(self.notes.count)
		print(model)
		print("555")
		//let _ = self.notes.map{
			//showCity(city: "kirov")
		//}
//		self.adapter?.update(notes: self.notes.map {
//								showCity(city: $0.name)
//
//		})
	}
	do {

		self.notes = try self.notesStorage.getNotes(for: self.user)
//		model = self.notes.map{
//			//showCity(city: $0.name)
//			//city.append($0.name)
//			Model(id: $0.uid, holder: $0.holder, name: $0.name)
//
//		}
//		//print(city)
//		print(model)
		print(self.notesStorage.notesCount())
	} catch {
		self.controller?.showAlert(message: "Ошибка загрузки данных")
		self.notes = []
//	}
}

	func reloadNotes() {
	self.displayNotes()
}

}
}
