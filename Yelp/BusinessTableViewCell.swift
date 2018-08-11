//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Nathan Ansel on 8/11/18.
//  Copyright © 2018 Nathan Ansel. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
	
	@IBOutlet weak var businessImageView: UIImageView!
	@IBOutlet weak var ratingImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var reviewLabel: UILabel!
	@IBOutlet weak var addressLabel: UILabel!
	@IBOutlet weak var categoriesLabel: UILabel!
	
	private let manager = ImageManager.shared
	
	override func awakeFromNib() {
		super.awakeFromNib()
		businessImageView.layer.cornerRadius = 4
	}
	
	func updateInterface(with business: Business?) {
		ratingImageView.image = business?.rating?.image
		titleLabel.text = business?.name
		if let count = business?.reviewCount {
			reviewLabel.text = "\(count) Reviews"
		} else {
			reviewLabel.text = nil
		}
		addressLabel.text = business?.location?.displayValue
		if let categories = business?.categories {
			categoriesLabel.text = categories
				.map { $0.title }
				.compactMap { $0 }
				.joined(separator: ", ")
		} else {
			categoriesLabel.text = nil
		}
		businessImageView.image = business?.image
		if business?.image == nil, let path = business?.imageUrl {
			manager.image(
				forPath: path,
				success: { (image) in
					business?.image = image
					self.businessImageView.image = image
				}, failure: { (error) in
					print(error)
			})
		}
	}
}
