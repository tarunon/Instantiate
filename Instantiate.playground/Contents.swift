//: Playground - noun: a place where people can play

import AppKit
import PlaygroundSupport
import Instantiate
import InstantiateStandard

extension PlaygroundView: NibInstantiatable {
    public struct Dependency {
        var title: String
        var body: String
    }
    public func inject(_ dependency: Dependency) {
        self.titleLabel.stringValue = dependency.title
        self.textView.string = dependency.body
    }
}

let playgroundView = PlaygroundView(with: .init(title: "Hello world", body: "Wellcome to Instantiate Playground!\nThis is simple example."))
PlaygroundPage.current.liveView = playgroundView
