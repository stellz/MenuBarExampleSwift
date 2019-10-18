# MenuBarExampleSwift

Example Swift project implementing navigation menu bar. The project shows off a menu containing two options (Fruits & Vegetables) switching different data displayed in a table view. The project doesn't use storyboards. There are two view controllers - list view controller and an item view controller, created programmatically in code. For this simple project the MVC design pattern is used. When creating the item view controller instance, the model is being injected as a dependency in the designated initializer to follow best practices and for future testability of the class.

## UI Control

[Menu Bar](https://github.com/stellz/MenuBar)

* Example Usage:
```swift
// MARK: - Menu bar initialisation

// Create menu object and give it a frame
let menu = MenuBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width - 2*15, height: navigationController?.navigationBar.intrinsicContentSize.height ?? 0)) 
// Put as many items as you want to have in you menu bar
menu.items = ["Item 1", "Item 2", "Item 3"] 
// Don't forget to set the delegate
menu.delegate = self 
// Add the menu to the navigation bar
navigationItem.titleView = menu 

// MARK: - Menu bar delegate

func menuBar(_ menuBar: MenuBar, didSelect index: Int) {
    print("Selected menu item: \(index)")
}
```

## Example project in Objective C

[MenuBarExampleObjectiveC](https://github.com/stellz/MenuBarExampleObjectiveC)

## Build tools

* Xcode 10.3
* Swift 5
* iOS 12.4
