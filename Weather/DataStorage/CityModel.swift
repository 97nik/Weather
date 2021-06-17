//
//  NoteModel.swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//

import Foundation

final class CityModel: Encodable {
	let uid: UUID
	let holder: UUID
	private(set) var date: Date
	private(set) var name: String

	init(holder: UUID, name: String) {
		self.uid = UUID()
		self.date = Date()
		self.holder = holder
		self.name = name
	}

	init(uid: UUID, holder: UUID, date: Date, name: String) {
		self.uid = uid
		self.holder = holder
		self.date = date
		self.name = name
	}

	init?(city: City) {
		guard let uid = city.uid,
			  let holder = city.holder?.uid,
			  let date = city.date,
			  let name = city.name else { return nil }
		self.uid = uid
		self.holder = holder
		self.date = date
		self.name = name
	}

	func update(name: String) {
		self.date = Date()
		self.name = name
	}
}
