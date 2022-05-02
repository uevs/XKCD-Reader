//
//  CardView.swift
//  XKCD Reader
//
//  Created by leonardo on 29/04/22.
//

import SwiftUI

struct CardView: View {
    /// The card is used inside the LazyVGrid and displays the comic title, number and image preview. Can be tapped to access the comic details
    
    @State var showComic = false
    @State var comic: Comic
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.black,lineWidth: 2)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
            
            VStack(alignment: .leading) {
                Text(verbatim: "#\(comic.num)")
                    .font(.title3)
                    .padding([.top,.horizontal])
                
                Text(comic.title)
                    .font(.title)
                    .foregroundColor(.black)
                    .padding([.bottom, .horizontal])
                
                ZStack {
                    AsyncImage(url: URL(string: comic.img), content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding()
                    }, placeholder: {
                        Image("placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxHeight: 200)
                            .padding()
                    })
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                    showComic.toggle()
                            } label: {
                                Image(systemName: "chevron.right.circle.fill")
                                    .resizable()
                                    .foregroundColor(.accentColor)
                                    .aspectRatio(contentMode: .fit)
                                    .background(Circle().fill(.white))
                                    .frame(height: 35)
                                    .padding(10)
                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
        .frame(width: UIScreen.main.bounds.width)
        .fullScreenCover(isPresented: $showComic) {
            ComicView(comic: $comic, showComic: $showComic)
        }
    }
}
