# Instantiate
[![Build Status](https://travis-ci.org/tarunon/Instantiate.svg?branch=master)](https://travis-ci.org/tarunon/Instantiate)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

Type-safe InterfaceBuilder protocols.

## Summary

Storyboard and Nib is not type safe, if you use `UIStoryboard` or `UINib`, your code would be get some gloom.
Instantiate take type-safe protocols for Storyboard and Nib. Lets' improve our code with type-safe protocols!

### as is
```swift
let storyboard = UIStoryboard(name: "ViewController", bundle: Bundle.main)
let vc = storyboard.instantiateInitialViewController() as! ViewController
vc.bind(resource: [1, 2, 3])
```

### to be
```swift
let vc = ViewController.instantiate(with: [1, 2, 3])
```


## Protocols
### StoryboardInstantiatable
Supports using viewController with Storyboard. Implement `StoryboardInstantiatable` at your viewController class, then you can use `ViewController.instantiate(with: Parameter)`.
### NibInstantiatable
Supports using view with Nib. Implement `NibInstantiatable` at your view class, then you can use `View.instantiate(with: Parameter)`.
#### NibInstantiatableWrapper
Supports using view implements NibInstantiatable in other InterfaceBuilder. NibInstantiatableWrapper supports workaround. Make new `UIView` subclass, and implement `NibInstantiatableWrapper`, call `loadView` on `init(coder:)` and `prepareForInterfaceBuilder`. 
http://stackoverflow.com/questions/27807951/how-to-embed-a-custom-view-xib-in-a-storyboard-scene
### Reusable
Supports `UITableViewCell` / `UICollectionViewCell` reuse features.

## InstantiateStandard
`StoryboardType` and `NibType` required `static var storyboard` or `static var nib`. You need to write these values on own class, it is troublesome...
Many developer define StoryboardName is same of ClassName, and if you are also, you can use `InstantiateStandard`.
This libraly add default implementation of `StoryboardType`, `NibType`, and `Reusable`. 
