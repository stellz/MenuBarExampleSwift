//
//  ViewController.swift
//  MenuBarExampleSwift
//
//  Created by Stela Sadova on 15.10.19.
//  Copyright © 2019 Stela Sadova. All rights reserved.
//

import UIKit

class ItemsListViewController: UITableViewController, MenuBarDelegate {

    var selectedIndex = 0
    var data = [[[String]]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")

        addMenuBar()
        addItemsToList()
    }

    private func addMenuBar() {
        let menu = MenuBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width - 2*15, height: navigationController?.navigationBar.intrinsicContentSize.height ?? 0))
        menu.items = ["Fruits", "Veggies"]
        menu.delegate = self
        navigationItem.titleView = menu
    }

    private func addItemsToList() {
        let firstFruitGroup = ["Apple", "Pear", "Cherries"]
        let secondFruitGroup = ["Kiwi", "Orange", "Banana"]
        let firstVeggieGroup = ["Tomato", "Cucumber", "Pepper"]
        let secondVeggieGroup = ["Carrot", "Cabbage", "Brokoli"]
        data = [[firstFruitGroup, secondFruitGroup], [firstVeggieGroup, secondVeggieGroup]]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedMenuData = data[selectedIndex]
        let sectionData = selectedMenuData[selectedIndex]
        return sectionData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") ?? UITableViewCell()
        let selectedMenuData = data[selectedIndex]
        let sectionData = selectedMenuData[indexPath.section]
        cell.textLabel?.text = sectionData[indexPath.row]
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .groupTableViewBackground
        return header
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMenuData = data[selectedIndex]
        let sectionData = selectedMenuData[indexPath.section]
        let name = sectionData[indexPath.row]

        let item = Item(name: name)
        let itemVC = ItemViewController(item: item)

        navigationController?.pushViewController(itemVC, animated: true)
    }

    // MARK: - Menu bar delegate

    func menuBar(_ menuBar: MenuBar, didSelect index: Int) {
        selectedIndex = index
        print("Selected menu item: \(index)")
        tableView.reloadData()
    }
}

