//
//  DataStorage .swift
//  Weather
//
//  Created by Никита on 15.06.2021.
//

import Foundation
import CoreData

final class CoreDataStorage {
	private enum Constants {
		static let containerName = "Weather"
		static let entityName = "City"
	}

	private lazy var container: NSPersistentContainer = {
		let container = NSPersistentContainer(name: Constants.containerName)
		container.loadPersistentStores(completionHandler: { (_, error) in
			guard let error = error as NSError? else { return }
			fatalError("Unresolved error \(error), \(error.userInfo)")
		})
		return container
	}()
}


extension CoreDataStorage: IUserStorage {
	func getUser(login: String, password: String) -> UserModel? {
		let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "\(#keyPath(User.login)) = '\(login)' && \(#keyPath(User.password)) = '\(password)'")
		guard let object = try? self.container.viewContext.fetch(fetchRequest).first else { return nil }
		return UserModel(user: object)
	}

	func saveUser(user: UserModel, completion: @escaping () -> Void) {
		self.container.performBackgroundTask { context in
			let object = User(context: context)
			object.uid = user.uid
			object.login = user.login
			object.password = user.password
			try? context.save()
			DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { completion() })
		}
	}

	func usersCount() -> Int {
		let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
		return (try? self.container.viewContext.count(for: fetchRequest)) ?? 0
	}
}


extension CoreDataStorage: ICityStorage {
	func deleteAll() {
		let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
		if let objects = try? container.viewContext.fetch(fetchRequest) {
			for object in objects {
				container.viewContext.delete(object)
			}
		}
		do {
			try container.viewContext.save()
		} catch let error {
			//self.errorPresenter?.presentError(error: .deleteAllError)
			print(error.localizedDescription)
		}
	}
	func getNotes(for user: UserModel) throws -> [CityModel] {
		let calendar = Calendar.current
		let currentYear = calendar.dateComponents([.year], from: Date())
		let startOfThisYear = calendar.date(from: currentYear)!
		let nextYear = DateComponents(year: currentYear.year! + 1)
		let startOfNextYear = calendar.date(from: nextYear)!

		let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
//		 NSPredicate(format: "ANY holder.uid = '\(user.uid)' AND (title CONTAINS[c] '1' OR title CONTAINS[c] '2')
		fetchRequest.predicate = NSPredicate(format: "ANY holder.uid = '\(user.uid)' AND \(#keyPath(City.date)) >= %@ AND \(#keyPath(City.date)) < %@", argumentArray: [startOfThisYear, startOfNextYear])
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(City.date), ascending: false)]
		do {
			return try self.container.viewContext.fetch(fetchRequest).compactMap { CityModel(city: $0) }
		} catch {
			print(error.localizedDescription)
			throw NoteException.saveFailed
		}
	}
	func notesCount() -> Int {
		let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
		//print("\(try? self.container.viewContext.count(for: fetchRequest) ?? 0)")
		return (try? self.container.viewContext.count(for: fetchRequest)) ?? 0
	}
	func create(city: CityModel, completion: @escaping (NoteException?) -> Void) {
		self.container.performBackgroundTask { context in
			do {
				print("check")
				let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
				fetchRequest.predicate = NSPredicate(format: "\(#keyPath(User.uid)) = '\(city.holder)'")
				guard let user = try context.fetch(fetchRequest).first else { return }
				let object = City(context: context)
				object.uid = city.uid
				object.name = city.name
				object.date = city.date
				object.holder = user
				if context.hasChanges {
					do {
						try context.save()
					} catch {
					  context.rollback()
						let nserror = error as NSError
						fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
					}
				}
				DispatchQueue.main.async { completion(nil) }
			} catch {
				DispatchQueue.main.async { completion(NoteException.saveFailed) }
			}
		}
	}
	
//	func saveContext (context: context) {
//		  if context.hasChanges {
//			  do {
//				  try context.save()
//			  } catch {
//				context.rollback()
//				  let nserror = error as NSError
//				  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//			  }
//		  }
//	  }

	func update(note: CityModel, completion: @escaping (NoteException?) -> Void) {
		self.container.performBackgroundTask { context in
			let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
			fetchRequest.predicate = NSPredicate(format: "\(#keyPath(City.uid)) = %@", note.uid.uuidString)
			if let object = try? context.fetch(fetchRequest).first {
				//object.title = note.title
				object.name = note.name
				object.date = note.date
			}
			try? context.save()
			DispatchQueue.main.async { completion(nil) }
		}
	}

	func remove(note: CityModel, completion: @escaping (NoteException?) -> Void) {
		self.container.performBackgroundTask { context in
			let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
			fetchRequest.predicate = NSPredicate(format: "\(#keyPath(City.uid)) = %@", note.uid.uuidString)
			do {
				if let object = try context.fetch(fetchRequest).first {
					context.delete(object)
					try context.save()
				}
				DispatchQueue.main.async { completion(nil) }
			} catch {
				DispatchQueue.main.async { completion(NoteException.removeFailed) }
			}
		}
	}
}
