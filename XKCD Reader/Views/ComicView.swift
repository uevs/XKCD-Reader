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
    @State var fullImage: Bool = false


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
                .onTapGesture {
                    fullImage.toggle()
                }
   
        
                Text("**Date:** \(comic.formatDate().formatted(date: .abbreviated, time: .omitted))")
                
                Divider()
                
                SpoilerTextView(title: "Alt Text", content: comic.alt)
                
                Divider()
                
                SpoilerTextView(title: "Explanation", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus dictum vestibulum tempor. Morbi sit amet volutpat diam. Ut consequat luctus mauris congue laoreet. In molestie diam risus, imperdiet vulputate nulla laoreet vel. Nulla vitae eleifend tortor. Integer mi lectus, suscipit id maximus sed, congue nec erat. Ut nec hendrerit velit. Curabitur vehicula blandit ligula non vehicula. Donec a lacinia nisl. Nulla feugiat elit nec ultricies finibus.")
                
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
        .fullScreenCover(isPresented: $fullImage) {
            FullScreenView(dismiss: $fullImage, comic: $comic)
        }
    }
}

struct ComicFooterView: View {
    @EnvironmentObject var comics: Comics
    @Binding var comic: Comic

    var body: some View {
        HStack {
            Button {
                withAnimation {
                    if comics.comics.firstIndex(of: comic) != 0 {
                        comic = comics.comics.filter({$0.num == comic.num+1})[0]
                    }                    
                }
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
                withAnimation {
                    if comics.comics.firstIndex(of: comic) != comics.comics.endIndex-1 {
                        comic = comics.comics.filter({$0.num == comic.num-1})[0]
                    }
                    
                }
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
