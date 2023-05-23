//
//  ProfileRow.swift
//  Doppler Manager
//
//  Created by Amit Samant on 16/06/21.
//

import SwiftUI

struct ProfileRow: View {
    let isSelected: Bool
    let profile: Profile
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "chevron.left.forwardslash.chevron.right")
                .frame(width: 44, height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(.tertiary)
                )
                .foregroundStyle(.blue)
            VStack(alignment: .leading, spacing: 5) {
                Text(profile.name)
                    .lineLimit(1)
                HStack {
                    if !profile.project.isEmpty {
                        Text(profile.project.uppercased())
                            .font(
                                .system(
                                    size: 8,
                                    weight: .bold,
                                    design: .monospaced
                                )
                            )
                            .padding(4)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 4,
                                    style: .continuous
                                ).fill(.primary)
                            )
                    }
                    if !profile.config.isEmpty {
                        Text(profile.config.uppercased())
                            .font(
                                .system(
                                    size: 8,
                                    weight: .bold,
                                    design: .rounded
                                )
                            )
                            .padding(4)
                            .foregroundColor(.blue)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: 4,
                                    style: .continuous
                                ).fill(.quaternary)
                            )
                    }
                }
                .padding(.bottom, 5)
                .foregroundStyle(.blue)
            }
            Spacer()
            if isSelected {
                Image(systemName:  "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
        .padding(.vertical, 8)
        .frame(minWidth: 0, maxWidth: .infinity)
        .contentShape(Rectangle())
    }
}

struct ProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                ProfileRow(isSelected: true, profile: .init(name: "Amit Samant", key: "", project: "Zomato", config: "Development"))
            }
        }
        .preferredColorScheme(.dark)
    }
}
