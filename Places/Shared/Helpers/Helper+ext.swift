//
//  Helper+ext.swift
//  Places
//
//  Created by Bob Godwin Obi on 27.01.21.
//

import Foundation
import SwiftUI

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


extension View {
    func iOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(iOS)
        return modifier(self)
        #else
        return self
        #endif
    }
    
    func macOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(macOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}

struct primaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .background(configuration.isPressed ? Color.blue.opacity(0.5) : Color.blue )
            .foregroundColor(Color.white)
            .clipShape(Capsule())
    }
}
