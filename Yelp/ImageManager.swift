//
//  ImageManager.swift
//  Flix
//
//  Created by Nathan Ansel on 8/3/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

class ImageManager {
	private var isLoadingPaths: [String] = []
	
	static var shared = ImageManager()
	
	typealias ImageSuccess = (UIImage) -> Void
	typealias ImageFailure = (Error) -> Void
	func image(forPath path: String, success: @escaping ImageSuccess, failure: @escaping ImageFailure) {
		guard !isLoadingPaths.contains(path) else {
			return
		}
		isLoadingPaths.append(path)
		
		let components = URLComponents(string: path)
		guard let url = components?.url else {
			fatalError("Invalid image url for path: \(path)")
		}
		let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
		let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
		let task = session.dataTask(with: request) { (data, response, error) in
			if let index = self.isLoadingPaths.index(of: path) {
				self.isLoadingPaths.remove(at: index)
			}
			guard error == nil else {
				// Inform the UI about any errors
				failure(error!)
				return
			}
			guard let data = data, !data.isEmpty else {
				// TODO: Inform the UI about incorrect data
				return
			}
			if let image = UIImage(data: data) {
				success(image)
			} else {
				print(String.init(data: data, encoding: .utf8) as Any)
				// TODO: Inform the UI about the image not working
			}
		}
		task.resume()
	}
}
