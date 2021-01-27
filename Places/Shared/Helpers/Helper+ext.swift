//
//  Helper+ext.swift
//  Places
//
//  Created by Bob Godwin Obi on 27.01.21.
//

import Foundation

public extension Optional {
    func unwrap(hint hintNote: @autoclosure () -> String? = nil,
                file: StaticString = #file,
                line: UInt = #line) -> Wrapped {
        guard let unwrapped = self else {
            var message = "Error trying to force unwrap value in \(file) on line \(line)"
            if let hint = hintNote() {
                message.append(". Debug hint: \(hint)")
                let exeception = NSException(name: .invalidArgumentException, reason: message, userInfo: nil)
                exeception.raise()
            }
            preconditionFailure(message)
        }
        return unwrapped
    }
}
