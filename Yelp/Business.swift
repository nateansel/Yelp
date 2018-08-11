//
//  Business.swift
//  Yelp
//
//  Created by Nathan Ansel on 8/11/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

class Business: Codable {
	struct Category: Codable {
		var title: String?
	}
	
	struct Location: Codable {
		var address1: String?
		var address2: String?
		var city: String?
		var state: String?
		var zipCode: String?
		
		var displayValue: String {
			var toReturn = ""
			if let address1 = address1 {
				toReturn += address1
				if let address2 = address2 {
					toReturn += ", \(address2)"
				}
				if let city = city {
					toReturn += " \(city)"
					if let state = state {
						toReturn += " \(state)"
					}
				} else if let state = state {
					toReturn += " \(state)"
				}
			} else if let address2 = address2 {
				toReturn += ", \(address2)"
				if let city = city {
					toReturn += " \(city)"
					if let state = state {
						toReturn += " \(state)"
					}
				} else if let state = state {
					toReturn += " \(state)"
				}
			} else if let city = city {
				toReturn += city
				if let state = state {
					toReturn += state
				}
			} else if let state = state {
				toReturn += state
			}
			return toReturn
		}
	}
	
	enum Rating: Float, Codable {
		case zero = 0
		case one = 1
		case oneHalf = 1.5
		case two = 2
		case twoHalf = 2.5
		case three = 3
		case threeHalf = 3.5
		case four = 4
		case fourHalf = 4.5
		case five = 5
		
		var image: UIImage {
			switch self {
			case .zero: return #imageLiteral(resourceName: "stars_0")
			case .one: return #imageLiteral(resourceName: "stars_1")
			case .oneHalf: return #imageLiteral(resourceName: "stars_1_half")
			case .two: return #imageLiteral(resourceName: "stars_2")
			case .twoHalf: return #imageLiteral(resourceName: "stars_2_half")
			case .three: return #imageLiteral(resourceName: "stars_3")
			case .threeHalf: return #imageLiteral(resourceName: "stars_3_half")
			case .four: return #imageLiteral(resourceName: "stars_4")
			case .fourHalf: return #imageLiteral(resourceName: "stars_4_half")
			case .five: return #imageLiteral(resourceName: "stars_5")
			}
		}
	}
	
	let name: String?
	let location: Location?
	let imageUrl: String?
	let categories: [Category]
	let distance: Double?
	let rating: Rating?
	let reviewCount: Int?
	
	var image: UIImage?
	
	enum CodingKeys: String, CodingKey {
		case name, location, imageUrl, categories, distance, rating, reviewCount
	}
	
	init(name: String? = nil, location: Location? = nil, imageUrl: String? = nil, categories: [Category] = [], distance: Double? = nil, rating: Rating? = nil, reviewCount: Int? = nil, image: UIImage? = nil) {
		self.name = name
		self.location = location
		self.imageUrl = imageUrl
		self.categories = categories
		self.distance = distance
		self.rating = rating
		self.reviewCount = reviewCount
		self.image = image
	}
}
