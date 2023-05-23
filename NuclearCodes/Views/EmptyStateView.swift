//
//  EmptyStateView.swift
//  EmptyStateView
//
//  Created by Amit Samant on 22/08/21.
//

import SwiftUI

struct EmptyStateView: View {
    let action: () -> Void
    init(_ action: @escaping () -> Void) {
        self.action = action
    }
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
            Image(systemName: "terminal.fill")
                    .font(.largeTitle)
            Text("Empty repository")
                    .font(.headline)
            Text("Feels empty does'nt it ?")
                    .bold()
                    .font(.system(.caption, design: .monospaced))
                    .foregroundStyle(.secondary)
            }
            Button {
                action()
            } label: {
                Text("Reload")
                    .font(.system(.caption, design: .monospaced))
                    .padding(8)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke()
                    )
            }
        }
        .frame(minWidth: 100)
        .padding()
        .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(.quaternary))
        .foregroundStyle(.blue)
        .background(
            RoundedRectangle(
                cornerRadius: 18,
                style: .continuous
            ).fill(Color(uiColor: UIColor.systemBackground))
        )
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView {}
    }
}
