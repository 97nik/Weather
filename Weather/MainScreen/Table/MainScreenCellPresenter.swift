//
//  MainScreenCellPresenter.swift
//  Weather
//
//  Created by Никита on 16.06.2021.
//

import Foundation
class MainScreenCellPresenter {
	private let city: MainScreenItemViewModel
	private weak var view: MainScreenNoteCell?
	
	init(cityModel: ForecastWeatherModel) {
		self.city = MainScreenCellPresenter.convert(city: cityModel)
	}
	
	func didLoadView(view: MainScreenNoteCell) {
		self.view = view
		self.updateView()
	}
	
	private func updateView() {
		self.view?.update(vm: city)
	}
	
	private static func convert(city: ForecastWeatherModel)-> MainScreenItemViewModel {
		let lol = MainScreenItemViewModel(name: city.cityName, cold: city.stateCode, temp: city.stateCode)
		print(lol)
		return MainScreenItemViewModel(name: city.cityName, cold: city.stateCode, temp: city.stateCode)
	}
}
