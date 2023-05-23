//
//  SectionIndexedTitleView.swift
//  SectionIndexedTitleView
//
//  Created by Amit Samant on 23/08/21.
//

import SwiftUI

struct SectionIndexedTitleView: View {
    let text: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .foregroundColor(Color(uiColor: .quaternarySystemFill))
            .frame(width: 15, height: 20)
            .overlay(
                Text(text.prefix(1))
                    .bold()
                    .font(.caption)
                    .foregroundColor(.blue)
            )
            .padding(.trailing, 2)
    }
}

struct SectionIndexedTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SectionIndexedTitleView(text: "A")
    }
}
