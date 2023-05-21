//
//  LoaderView.swift
//  LoaderView
//
//  Created by Amit Samant on 22/08/21.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ProgressView()
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: 10,
                    style: .continuous
                ).fill(.quaternary)
            )
            .foregroundStyle(.blue)
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
