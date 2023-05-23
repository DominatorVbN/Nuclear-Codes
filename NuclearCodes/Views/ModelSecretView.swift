//
//  ModelSecretView.swift
//  ModelSecretView
//
//  Created by Amit Samant on 22/08/21.
//

import SwiftUI

struct ModelSecretView: View {
    let modelItem: ValueModel
    var body: some View {
        GroupBox {
            HStack{
                Group {
                    HStack(spacing: 0) {
                        Text(modelItem.key)
                            .textSelection(.enabled)
                        Text(":")
                    }
                }
                .font(.system(.subheadline, design: .monospaced))
                Text(modelItem.value)
                Spacer()
            }
        }
        .contextMenu {
            Button ("Copy \(modelItem.key)") {}
        }
    }
}

struct ModelSecretView_Previews: PreviewProvider {
    static var previews: some View {
        ModelSecretView(modelItem: .init(key: "Some", value: "Some"))
    }
}
