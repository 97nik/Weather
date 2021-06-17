//
//  INoteStorage.swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//

import Foundation

protocol ICityStorage {
	func getNotes(for user: UserModel) throws -> [CityModel]
	func create(city: CityModel, completion: @escaping (NoteException?) -> Void)
	func update(note: CityModel, completion: @escaping (NoteException?) -> Void)
	func remove(note: CityModel, completion: @escaping (NoteException?) -> Void)
	func deleteAll()
	func notesCount() -> Int
}

enum NoteException: Error {
	case saveFailed
	case updateFailed
	case removeFailed
	case loadFailed
}
