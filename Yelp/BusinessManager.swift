//
//  BusinessManager.swift
//  Yelp
//
//  Created by Nathan Ansel on 8/11/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

struct SearchResults: Codable {
	var businesses: [Business]
	var total: Int
}

class BusinessManager {
	static let shared = BusinessManager()
	
	private enum Security {
		// You can register for Yelp API keys here: https://www.yelp.com/developers/v3/manage_app
		static private let apiKey = "izCFqEx0usiPwAiv_ymJ4Sl2Lr_mpnN6U_VeEkn1iUyEUWLM2Rd76A6NlswCI-HlYVWYT2WYRFtNnD04lgageyBKPJkqDDA75C8UsJYwc7oXWMGDFSCRU93zoTBaW3Yx"
		static let bearerToken = "Bearer \(apiKey)"
	}
	
	private enum Locations {
		static let base = "https://api.yelp.com/v3"
		static let search = base + "/businesses/search"
	}
	
	enum Sort: String {
		case bestMatch = "best_match"
		case reviewCount = "review_count"
		case rating, distance
	}
	
	
	typealias SearchSuccess = (SearchResults) -> Void
	typealias SearchFailure = (Error) -> Void
	func search(for searchText: String? = nil, sortBy sort: Sort? = nil, categories: [String]? = nil, openNow: Bool? = nil, offset: Int? = nil, success: @escaping SearchSuccess, failure: @escaping SearchFailure) {
		var components = URLComponents(string: Locations.search)
		components?.queryItems = []
		components?.queryItems?.append(URLQueryItem(name: "location", value: "37.785771,-122.406165"))
		if let searchText = searchText {
			components?.queryItems?.append(URLQueryItem(name: "term", value: searchText))
		}
		if let offset = offset {
			components?.queryItems?.append(URLQueryItem(name: "page", value: "\(offset)"))
		}
		guard let url = components?.url else {
			fatalError("Invalid Search url: \(components as Any)")
		}
		var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
		request.httpMethod = "GET"
		request.addValue(Security.bearerToken, forHTTPHeaderField: "Authorization")
		let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
		let task = session.dataTask(with: request) { (data, response, error) in
			guard error == nil else {
				// Inform the UI about any errors
				failure(error!)
				return
			}
			guard let data = data, !data.isEmpty else {
				// TODO: Inform the UI about incorrect data
				return
			}
			
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			do {
				let results = try decoder.decode(SearchResults.self, from: data)
				print(String(data: data, encoding: .utf8) as Any)
				success(results)
			} catch {
				print(error)
				print(String(data: data, encoding: .utf8) as Any)
				failure(error)
			}
		}
		task.resume()
	}
}
