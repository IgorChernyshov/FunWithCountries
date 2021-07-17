//
//  DetailsViewController.swift
//  FunWithCountries
//
//  Created by Igor Chernyshov on 17.07.2021.
//

import UIKit

final class DetailsViewController: UITableViewController {

	// MARK: - Properties
	var viewModel: Country? {
		willSet {
			guard let model = newValue else { return }
			detailDataSource.removeAll()
			detailDataSource.append(model.name)
			detailDataSource.append(model.capital)
			detailDataSource.append(model.population)
			detailDataSource.append(model.nativeLanguage)
			tableView.reloadData()
		}
	}

	private let textDataSource: [String] = ["Country name", "Capital city", "Population", "Native language"]
	private var detailDataSource: [String] = []
}

// MARK: - UITableViewDelegate
extension DetailsViewController {

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		detailDataSource.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Details", for: indexPath)
		cell.textLabel?.text = textDataSource[indexPath.row]
		cell.detailTextLabel?.text = detailDataSource[indexPath.row]
		return cell
	}
}
