//
//  TipView.swift
//  Places
//
//  Created by Bob Godwin Obi on 04.02.21.
//

import SwiftUI

struct TipView: View {
    let tip: Tip
    var body: some View {
        if tip.children != nil {
            Label(tip.text, systemImage: "quote.bubble")
                .font(.headline)
        } else {
            Text(tip.text)
        }
    }
}

struct TipView_Previews: PreviewProvider {
    static var previews: some View {
        let children = [Tip(text: "Hello world 1", children: nil),
                        Tip(text: "Hello world 2", children: nil),]
        let tip = Tip(text: "Hello world", children: children)
        TipView(tip: tip)
    }
}
