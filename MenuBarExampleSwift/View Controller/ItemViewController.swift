//
//  ItemViewController.swift
//  MenuBarExampleSwift
//
//  Created by Stela Sadova on 16.10.19.
//  Copyright © 2019 Stela Sadova. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    let item: Item?

    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = item?.name
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 100),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)])

    }
}
