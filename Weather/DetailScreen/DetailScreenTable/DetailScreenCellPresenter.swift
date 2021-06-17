//
//  DetailScreenCellPresenter.swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//
import Foundation

//dayOfWeek: [("Monday","sun"),( "Tuesday","sun"), ("Wednesday","sun"), ("Thursday","sun"), ("Friday","sun"), ("​Saturday","sun")])

struct ModelTableItem {
	let degreesDay: Int
	let degreesNight: Int
	let dayOfWeek: String
	let imageSkyStatus: String
}

class DetailScreenCellPresenter {
	private let model: ModelTableItem
	private weak var view: DetailScreenNoteCell?
	
	init(city: CityModel) {
		self.model = DetailScreenCellPresenter.convertQuotes(city: city)
	}
	
	private static func convertQuotes(city: CityModel) -> ModelTableItem {
		return ModelTableItem(degreesDay: 10, degreesNight: 10, dayOfWeek: "Monday", imageSkyStatus: "Sun")
	}
	
	func didLoadView(view: DetailScreenNoteCell) {
		self.view = view
		self.updateView()
	}
	
	private func updateView() {
		self.view?.setQuote(self.model)
	}
}
