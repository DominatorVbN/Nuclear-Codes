//
//  SecretItem.swift
//  Doppler Manager
//
//  Created by Amit Samant on 16/06/21.
//

import Foundation

struct ValueModel: Identifiable {
    var key: String
    var value: String
    
    var id: String {
        key + value
    }
}

struct SecretItem: Identifiable, Comparable {
    static func < (lhs: SecretItem, rhs: SecretItem) -> Bool {
        lhs.path < rhs.path
    }
    
    static func == (lhs: SecretItem, rhs: SecretItem) -> Bool {
        lhs.id == rhs.id
    }
    
    
//    static var preview: [SecretItem] = [
//        SecretItem.init(value: .string("Some Text"), path: ["Linkedin"]),
//        SecretItem.init(value: .model([
//            .init(key: "id", value: "amit.samant@gmail.com"),
//            .init(key: "Password", value: "LikeIWillWriteItDownYouBet")
//        ]), path: ["Google"]),
//        SecretItem.init(value: .model([
//            .init(key: "id", value: "amit.samant@fb.com"),
//            .init(key: "Password", value: "LikeIWillWriteItDownYouBet")
//        ]), path: ["Facebook"]),
//        SecretItem.init(value: .string("Some Text"), path: ["Tinder"])
//    ]

    enum ValueType {
        case string(String)
        case model([ValueModel])
        case nested([Dictionary<String, [ValueModel]>.Element])
    }
    
    let value: ValueType
    let path: String
    var displayPath: String {
        path
            .capitalized
            .components(separatedBy: "_")
            .joined(separator: " ")
    }
    let id = UUID()
    
}

enum DopplerAPIError: Error {
    case failed(withMessages: [String])
    
    init?(json: Any) {
        guard let json = json as? [String: Any] else {
            return nil
        }
        let messages = (json["messages"] as? [String]) ?? []
        self = .failed(withMessages: messages)
    }
}

extension Array where Element == SecretItem {
    
//    func vaibhavFormatted() -> Self {
//        map { element in
////            let value = element.value
////            switch value {
////                case .model(let valueItems):
////                case .string(let value):
////            }
//            let new
//        }
//    }
    static func from(jsonObject: Any) throws -> Self {
        guard let dict = jsonObject as? [String: Any],
              let secretsDict = dict["secrets"] as? [String: [String: String]]
        else {
            if let error = DopplerAPIError(json: jsonObject) {
                throw error
            } else {
                throw DopplerAPIError.failed(withMessages: [])
            }
        }
        var tempItems = [SecretItem]()
        for (key, innerDict) in secretsDict {
            let value = innerDict["computed"]!
            guard let jsonData = value.data(using: .utf8),
                  let jsonDictionary = try? JSONSerialization.jsonObject(
                    with: jsonData,
                    options: .mutableLeaves
                  )  else {
                      if !value.isEmpty {
                          tempItems.append(.init(value: .string(value), path: key))
                      }
                      continue
                  }
            if let rootDict = jsonDictionary as? [String: String] {
                let valueModels = rootDict.map(ValueModel.init).sorted(by: { $0.key.count < $1.key.count })
                guard !valueModels.isEmpty else {
                    continue
                }
                tempItems.append(
                    SecretItem(
                        value: .model(valueModels),
                        path: key
                    )
                )
            } else if let rootDict = jsonDictionary as? [String: [String: String]] {
                var innerTempDict: [String: [ValueModel]] = [:]
                for (rootDictKey, rootDictValue) in rootDict {
                    let valueModels = rootDictValue.map(ValueModel.init).sorted(by: { $0.key.count < $1.key.count })
                    guard !valueModels.isEmpty else {
                        continue
                    }
                    innerTempDict[rootDictKey] = valueModels
                }
                let sortedDict = innerTempDict.sorted(by: { $0.key < $1.key })
                tempItems.append(SecretItem(value: .nested(sortedDict), path: key))
            } else {
                guard !value.isEmpty else {
                    continue
                }
                tempItems.append(.init(value: .string(value), path: key))
            }
        }
        return tempItems.sorted()
    }
    
}
