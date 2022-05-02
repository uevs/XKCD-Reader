//
//  FullScreenView.swift
//  XKCD Reader
//
//  Created by leonardo on 01/05/22.
//

import SwiftUI

struct FullScreenView: View {
    /// Shows the comic in fullscreen. Should have a zoom implementation in the future.
    
    @Binding var dismiss: Bool
    @Binding var comic: Comic
    @State var scale: CGFloat = 1
    
    var body: some View {
        AsyncImage(url: URL(string: comic.img), content: { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
        }, placeholder: {
            Image("placeholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
        })
        .onTapGesture {
            dismiss.toggle()
        }
    }
}


