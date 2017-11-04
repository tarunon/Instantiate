//
//  Deprecated.swift
//  Instantiate
//
//  Created by ST90872 on 2017/06/15.
//

import Foundation
import Instantiate

@available(*, deprecated, renamed: "IdentifierType.from")
public func identifier<I: IdentifierType>(of type: NSObjectProtocol.Type) -> I {
    return I.from(type.className)
}
