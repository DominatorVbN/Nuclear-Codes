//
//  SecretRow.swift
//  Doppler Manager
//
//  Created by Amit Samant on 17/06/21.
//

import SwiftUI

struct SecretRow: View {
    let secretItem: SecretItem
    var body: some View {
        VStack(alignment: .leading) {
            Text(secretItem.displayPath)
            Group {
                switch secretItem.value {
                    case .model(let valueItems):
                        Text(getAppropriateText(fromItems: valueItems))
                    case .string(let text):
                        Text(text)
                    case .nested(let arrayDict):
                        Text(arrayDict.map(\.key).joined(separator: ","))
                }
            }
            .font(.callout)
            .foregroundStyle(.secondary)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .contextMenu {
            switch secretItem.value {
                case .model(let valueItems):
                    ForEach(valueItems) { valueItem in
                        Button {
                            UIPasteboard.general.string = valueItem.value
                        } label: {
                            Label("Copy \(valueItem.key)", systemImage: "doc.on.doc")
                        }
                    }
                    
                case .string(let text):
                    Button {
                        UIPasteboard.general.string = text
                    } label: {
                        Label("Copy \(secretItem.path)", systemImage: "doc.on.doc")
                    }
                case .nested(let arrayDict):
                    ForEach(arrayDict, id:\.key) { element in
                        Menu(element.key) {
                            ForEach(element.value) { valueItem in
                                Button {
                                    UIPasteboard.general.string = valueItem.value
                                } label: {
                                    Label("Copy \(valueItem.key)", systemImage: "doc.on.doc")
                                }
                            }
                        }
                    }
            }
            Section {
                Button {
                    
                } label: {
                    Label("AirDrop...", systemImage: "square.and.arrow.up")
                }
            }
            Section {
                Button(role:.destructive) {
                    
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
    
    func getAppropriateText(fromItems items: [ValueModel]) -> String {
        if let id = items.first(where: { $0.key.lowercased().contains("id") }) {
            return id.value
        } else if let username = items.first(where: { $0.key.lowercased().contains("username") }) {
            return username.value
        } else if let password = items.first(where: { $0.key.lowercased().contains("password") }) {
            return (0..<password.value.count).reduce("", {
                initial, _ in
                return initial + "•"
            })
        } else if items.count > 0 {
            return items[0].value
        } else {
            return "No Values"
        }
    }
}

struct SecretRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            SecretRow(
                secretItem:
                    SecretItem(
                        value: .string("Some Text"),
                        path: "Google"
                    )
            )
            SecretRow(
                secretItem: SecretItem(
                    value: .model(
                        [
                            .init(key: "id", value: "amit.samant@gmail.com"),
                            .init(key: "Password", value: "LikeIWillWriteItDownYouBet")
                        ]
                    ),
                    path: "Google"
                )
            )
        }
        .preferredColorScheme(.dark)
    }
}
