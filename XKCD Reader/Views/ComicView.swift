//
//  ComicView.swift
//  XKCD Reader
//
//  Created by leonardo on 12/04/22.
//

import SwiftUI

struct ComicView: View {
    @Binding var comic: Comic
    @Binding var showComic: Bool
    @EnvironmentObject var comics: Comics
    
    var body: some View {
        ZStack {
            VStack(spacing:0) {
                ComicContentsView(comic: $comic)
                Spacer()
                Divider()
                ComicFooterView(comic: $comic)
            }
            DismissButtonView(showComic: $showComic)
        }
    }
}



struct ComicContentsView: View {
    @Binding var comic: Comic
    @EnvironmentObject var comics: Comics


    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    Text(comic.title)
                        .font(.title)
                        .padding(.top)
                    
                    Text(verbatim: "#\(comic.num)")
                        .font(.title3)
                        .padding(.bottom)
                }
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
        
                Text("**Date:** \(comic.formatDate().formatted(date: .abbreviated, time: .omitted))")
                
                Divider()
                
                SpoilerTextView(title: "Alt Text", content: comic.alt)
                
                Divider()
                
                SpoilerTextView(title: "Explanation", content: "Curabitur aliquet purus justo, nec malesuada velit iaculis eget. Sed non dignissim magna, id suscipit velit. Suspendisse est sapien, hendrerit vitae dui vitae, finibus tempus leo. Vivamus leo leo, suscipit sit amet arcu quis, maximus bibendum enim. In commodo, mauris a euismod facilisis, elit metus elementum quam, eu tincidunt lacus erat quis purus. Pellentesque non varius lectus. Maecenas eu varius leo, sit amet sodales ex. Aliquam erat volutpat.")
                
                Divider()
                
                HStack(alignment: .top) {
                Text("Link: ")
                    .bold()
                    Link(comic.link ?? "Not Available", destination: comic.findLink())
                        .disabled(comic.link == nil)
                        .truncationMode(.middle)
                        .lineLimit(1)
                }
                
                Spacer()
                
            }
            .padding(.horizontal)
            
        }
    }
}

struct ComicFooterView: View {
    @EnvironmentObject var comics: Comics
    @Binding var comic: Comic

    var body: some View {
        HStack {
            Button {
                // back
            } label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10)
            }
            .padding()
            
            Button {
                if comic.isFavorite(favorites: comics.favorites) {
                    comics.removeFromFavorites(comic: comic)
                } else {
                    comics.saveToFavorites(comic: comic)
                }
            } label: {
                Image(systemName: comic.isFavorite(favorites: comics.favorites) ? "star.fill" : "star")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
            }
            .padding()
            
            Button {
                // forward
            } label: {
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10)
            }
            .padding()
            
        }
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
    }
}

struct DismissButtonView: View {
    @Binding var showComic: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    showComic.toggle()
                } label: {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                }
                .padding()
            }
            
            Spacer()
        }
    }
}

struct SpoilerTextView: View {
    @State private var hidden: Bool = true
    @State var title: String
    @State var content: String
    
    var body: some View {
        HStack(alignment:.top) {
            Text("\(title): ")
                .bold()
            if hidden {
                Text("Tap to reveal!")
                    .font(.caption)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.ultraThinMaterial)
                
            } else {
                Text(content)
            }
            
            
        }
        .onTapGesture {
            hidden = false
        }
    }
}
