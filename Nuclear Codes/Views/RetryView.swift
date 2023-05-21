//
//  RetryView.swift
//  RetryView
//
//  Created by Amit Samant on 22/08/21.
//

import SwiftUI

struct RetryView: View {
    let messages: [String]
    let retryAction: () -> Void
    let changeProfileAction: () -> Void
    @State private var isSheetPresented: Bool = false
    init(_ messages: [String], retryAction: @escaping () -> Void, changeProfileAction: @escaping () -> Void) {
        self.messages = messages
        self.retryAction = retryAction
        self.changeProfileAction = changeProfileAction
    }
    var body: some View {
            VStack(spacing: 16) {
                VStack(spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.largeTitle)
                    Text("Something went wrong")
                        .padding(.horizontal)
                        .font(.headline)
                }
                if !messages.isEmpty {
                        VStack(alignment:.leading) {
                            ForEach(messages.prefix(4), id: \.self) { message in
                                Text(message)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .font(.system(.caption2, design: .monospaced))
                            }
                            if messages.count > 4 {
                                Button("more") {
                                    isSheetPresented = true
                                }
                                .font(.system(.caption2, design: .monospaced))
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8, style: .continuous).fill(.secondary))
                        .foregroundStyle(.black)
                }
                VStack {
                    Button {
                        changeProfileAction()
                    } label: {
                        Text("Change Profile")
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
                    Button {
                        retryAction()
                    } label: {
                        Text("Retry")
                            .font(.system(.caption, design: .monospaced))
                            .padding(8)
                            .padding(.horizontal)
                            .frame(minWidth:.zero, maxWidth: 200)
                            .background(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .stroke()
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
        .sheet(isPresented: $isSheetPresented) {
            NavigationView {
                List(messages, id: \.self) { message in
                    Text(message)
                        .font(.system(.caption, design: .monospaced))
                        .textSelection(.enabled)
                }
                .navigationTitle("Errors")
            }
        }
    }
}

struct RetryView_Previews: PreviewProvider {
    static var previews: some View {
        RetryView(["Some error has happened", "Some error has happened", "Some error has happened", "Some error has happened", "Some error has happened"]) {} changeProfileAction: {}
    }
}
