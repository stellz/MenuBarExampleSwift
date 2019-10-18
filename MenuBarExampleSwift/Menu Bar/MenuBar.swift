//
//  MenuBar.swift
//  MenuBar
//
//  Created by Stela Sadova on 23.07.19.
//  Copyright © 2019 Stela Sadova. All rights reserved.
//

import UIKit

@objc protocol MenuBarDelegate: AnyObject {
    /// Called when the selected menu item changes
    ///
    /// - Parameters:
    ///   - menuBar: The menu bar instance that triggered this call.
    ///   - index: The current index of the menu bar.
    func menuBar(_ menuBar: MenuBar, didSelect index: Int)
}

@objc class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var delegate: MenuBarDelegate?

    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    private var menuItems = ["Menu Item", "Menu Item"]
    @objc var items: Array<String>? {
        didSet {
            if let newItems = items, newItems.count > 1 {
                menuItems = newItems
                collectionView.reloadData()

                if let sliderWidthAnchorConstraintUnwrapped = sliderWidthAnchorConstraint,
                    let newConstraint = sliderWidthAnchorConstraintUnwrapped.constraintWithMultiplier(1/CGFloat(menuItems.count)) {
                    self.removeConstraint(sliderWidthAnchorConstraintUnwrapped)
                    self.addConstraint(newConstraint)
                    self.layoutIfNeeded()
                    sliderWidthAnchorConstraint = newConstraint
                }
            } else {
                assertionFailure("Menu items not set or less than 2")
            }
        }
    }

    private var sliderLeftAnchorConstraint: NSLayoutConstraint?
    private var sliderWidthAnchorConstraint: NSLayoutConstraint?

    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupCollectionView()
        setupSlider()
    }

    func setupCollectionView() {
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.reuseIdentifier)

        addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo:self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo:self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo:self.bottomAnchor)])


        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
    }

    func setupSlider() {
        let sliderView = UIView()
        sliderView.backgroundColor = .blue
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(sliderView)

        sliderLeftAnchorConstraint = sliderView.leftAnchor.constraint(equalTo: self.leftAnchor)
        sliderLeftAnchorConstraint?.isActive = true

        sliderView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sliderWidthAnchorConstraint = sliderView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/CGFloat(menuItems.count))
        sliderWidthAnchorConstraint?.isActive = true
        sliderView.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.reuseIdentifier, for: indexPath) as! MenuCell

        cell.label.text = menuItems[indexPath.item]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / CGFloat(menuItems.count), height: frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.item) * frame.width / CGFloat(menuItems.count)
        sliderLeftAnchorConstraint?.constant = x

        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)

        delegate?.menuBar(self, didSelect: indexPath.item)
    }

}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint? {
        guard let firstItem = self.firstItem else { return nil }
        return NSLayoutConstraint(item: firstItem, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
