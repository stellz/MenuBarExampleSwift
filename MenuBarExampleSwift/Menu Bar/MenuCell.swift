//
//  MenuCell.swift
//  MenuBar
//
//  Created by Stela Sadova on 23.07.19.
//  Copyright © 2019 Stela Sadova. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    func setupViews() {
        addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo:self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo:self.trailingAnchor),
            label.centerXAnchor.constraint(equalTo:self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo:self.centerYAnchor)])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let label: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.backgroundColor = .clear
        lbl.textColor = .gray
        lbl.textAlignment = .center
        return lbl
    }()

    override var isHighlighted: Bool {
        didSet {
            label.textColor = isHighlighted ? .gray : .black
        }
    }

    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? .black : .gray
        }
    }

}
