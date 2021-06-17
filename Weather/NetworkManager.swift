//
//  NetworkManager.swift
//  Weather
//
//  Created by Никита on 16.06.2021.
//

import Foundation
import UIKit


var cat = Data()

enum ApiError : Error {
	case noData
}
class NetworkService {
//	var onResult: ((Result<([CatElement],Int), Error>) -> Void)?
//
//	func fetchJson() {
//		let urlString = "https://cat-fact.herokuapp.com/facts"
//		performRequest(withURLString: urlString)

	
	
	 func performRequest (withURLString urlString: String, completion: @escaping (Result<ForecastWeatherModel, Error>) -> Void) {
		
	//	var onResult: ((Result<([T],Int), Error>) -> Void)?
		
		var statusCode = Int()
		guard let url = URL(string:"https://api.weatherbit.io/v2.0/forecast/daily?city=\(urlString)&country=RU&days=7&key=981ef900e54d484c8149ef25d7eb867e") else { return }
		let session = URLSession(configuration: .default)
		let task = session.dataTask(with: url) { data, response, error in
			if Reachability.isConnectedToNetwork(){
				if let httpResponse = response as? HTTPURLResponse {
					print(httpResponse.statusCode)
					statusCode = httpResponse.statusCode
					if httpResponse.statusCode == 404 {
						completion(.failure(ApiError.noData))
						return
					} else if httpResponse.statusCode != 200 {
						completion(.failure(ApiError.noData))
						return
					}
				}
				
				if let data = data {
					
					let decoder = JSONDecoder()
					do {
						let objects = try decoder.decode(ForecastWeatherModel.self, from: data)
						completion(.success(objects))
					} catch let error as NSError {
						completion(.failure(error))
						print(error.localizedDescription)
					}
				}else {
					completion(.failure(ApiError.noData))
					return
				}
			} else{
				print("Internet Connection not Available!")
				completion(.failure(ApiError.noData))
				return
			}
		}
		task.resume()
	}
	
	
	func fetchImage(_ code: Int, with delivery: @escaping (Data) -> Void){
		let url = "https://http.cat/\(code)"
		if let imageUrl = URL(string: url), let imageData = try? Data(contentsOf: imageUrl) {
			delivery(imageData)
		} else {
			print("er")
		}
	}
}

