//
//  ViewController.swift
//  FunWithCountries
//
//  Created by Igor Chernyshov on 17.07.2021.
//

import UIKit

final class ViewController: UITableViewController {

	// MARK: - Properties
	private var countries: [Country] = []

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Countries Information"
		loadData()
	}

	// MARK: - Data Processing
	private func loadData() {
		guard let dataURL = Bundle.main.url(forResource: "countriesData", withExtension: "json"),
			  let data = try? Data(contentsOf: dataURL),
			  let decodedData = try? JSONDecoder().decode([Country].self, from: data) else { return }
		countries = decodedData
		tableView.reloadData()
	}
}

// MARK: - UITableViewDataSource
extension ViewController {

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		countries.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
		cell.textLabel?.text = countries[indexPath.row].name
		return cell
	}
}

// MARK: - UITableViewDelegate
extension ViewController {

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let detailsViewController = storyboard?.instantiateViewController(identifier: "Details") as? DetailsViewController else {
			fatalError("Cannot instantiate Details View Controller")
		}
		detailsViewController.viewModel = countries[indexPath.row]
		navigationController?.pushViewController(detailsViewController, animated: UIView.areAnimationsEnabled)
		tableView.deselectRow(at: indexPath, animated: UIView.areAnimationsEnabled)
	}
}
