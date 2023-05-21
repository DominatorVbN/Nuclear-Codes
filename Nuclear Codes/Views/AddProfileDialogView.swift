//
//  AddProfileDialogView.swift
//  AddProfileDialogView
//
//  Created by Amit Samant on 23/08/21.
//

import SwiftUI

struct AddProfileDialogView: View {
    let addAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.largeTitle)
                Text("Please add profile")
                    .padding(.horizontal)
                    .font(.headline)
            }
            
            VStack {
                Button {
                    addAction()
                } label: {
                    Text("Add Profile")
                        .foregroundColor(.white)
                        .font(.system(.caption, design: .monospaced))
                        .padding(8)
                        .padding(.horizontal)
                        .frame(minWidth:.zero, maxWidth: 200)
                        .background(
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .fill()
                        )
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(.quaternary))
        .foregroundStyle(.blue)
        .background(
            RoundedRectangle(
                cornerRadius: 18,
                style: .continuous
            ).fill(Color(uiColor: UIColor.systemBackground))
        )
        .padding(.horizontal)
    }
}

struct AddProfileDialogView_Previews: PreviewProvider {
    static var previews: some View {
        AddProfileDialogView {}
    }
}
