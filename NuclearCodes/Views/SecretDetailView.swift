//
//  SecretDetailView.swift
//  SecretDetailView
//
//  Created by Amit Samant on 23/08/21.
//

import SwiftUI

struct SecretDetailView: View {
    let secretItem: SecretItem
    var body: some View {
        List {
            switch secretItem.value {
                case .string(let text):
                    Text(text)
                        .contextMenu {
                            Button {
                                UIPasteboard.general.string = text
                            } label: {
                                Label("Copy", systemImage: "doc.on.doc")
                            }
                        }
                case .model(let valueItems):
                    ForEach(valueItems) { valueItem in
                        HStack {
                            Text(valueItem.key.capitalized)
                            Spacer()
                            Text(valueItem.value)
                                .minimumScaleFactor(0.2)
                                .foregroundStyle(.secondary)
                        }
                        .lineLimit(1)
                        .contextMenu {
                            Button {
                                UIPasteboard.general.string = valueItem.value
                            } label: {
                                Label("Copy \(valueItem.key)", systemImage: "doc.on.doc")
                            }
                        }
                    }
                case .nested(let dictArray):
                    ForEach(dictArray, id: \.key) { dictElement in
                        Section {
                            ForEach(dictElement.value) { valueItem in
                                HStack {
                                    Text(valueItem.key)
                                    Spacer()
                                    Text(valueItem.value)
                                        .minimumScaleFactor(0.2)
                                        .foregroundStyle(.secondary)
                                }
                                .lineLimit(1)
                                .contextMenu {
                                    Button {
                                        UIPasteboard.general.string = valueItem.value
                                    } label: {
                                        Label("Copy \(valueItem.key)", systemImage: "doc.on.doc")
                                    }
                                }
                            }
                        } header: {
                            Text(dictElement.key.capitalized)
                        }
                    }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(secretItem.path.capitalized)
    }
}

struct SecretDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                SecretDetailView(
                    secretItem: SecretItem(
                        value: .nested(
                            [
                                "Primary": [
                                    ValueModel(key: "id", value: "amit.samant@icloud.com"),
                                    ValueModel(key: "password", value: "amit.samant")
                                ],
                                "Secondary": [
                                    ValueModel(key: "id", value: "amit.samant@zomato.com"),
                                    ValueModel(key: "password", value: "amit.samant")
                                ],
                            ].sorted(by: { $0.key < $1.key })
                        ),
                        path: "iCloud"
                    )
                )
            }
            NavigationView {
                SecretDetailView(
                    secretItem: SecretItem(
                        value: .model([
                            ValueModel(key: "id", value: "amit.samant@icloud.com"),
                            ValueModel(key: "password", value: "amit.samant")
                        ]),
                        path: "iCloud"
                    )
                )
            }
            NavigationView {
                SecretDetailView(
                    secretItem: SecretItem(
                        value: .string("Text"),
                        path: "iCloud"
                    )
                )
            }
        }
    }
}
