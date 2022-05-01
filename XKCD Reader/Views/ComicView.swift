//
//  ComicView.swift
//  XKCD Reader
//
//  Created by leonardo on 12/04/22.
//

import SwiftUI

struct ComicView: View {
    @Binding var showComic: Bool
    
    var body: some View {
        ZStack {
            VStack(spacing:0) {
                ComicContentsView()
                Spacer()
                Divider()
                ComicFooterView()
            }
            DismissButtonView(showComic: $showComic)
        }
    }
}



struct ComicContentsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    Text("Title")
                        .font(.title)
                        .padding(.top)
                    
                    Text("#0000")
                        .font(.title3)
                        .padding(.bottom)
                }
                
                Image("security")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                
                Text("Date: ")
                    .bold()
                
                Divider()
                
                SpoilerTextView(title: "Alt Text", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at eleifend nibh. Ut ac metus lacus. Mauris eu odio in dolor ultrices faucibus eu eget erat.")
                
                Divider()
                
                SpoilerTextView(title: "Explanation", content: "Curabitur aliquet purus justo, nec malesuada velit iaculis eget. Sed non dignissim magna, id suscipit velit. Suspendisse est sapien, hendrerit vitae dui vitae, finibus tempus leo. Vivamus leo leo, suscipit sit amet arcu quis, maximus bibendum enim. In commodo, mauris a euismod facilisis, elit metus elementum quam, eu tincidunt lacus erat quis purus. Pellentesque non varius lectus. Maecenas eu varius leo, sit amet sodales ex. Aliquam erat volutpat.")
                
                Divider()
                
                Text("Link: ")
                    .bold()
                
                Spacer()
                
            }
            .padding(.horizontal)
            
        }
    }
}

struct ComicFooterView: View {
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
                // favorite
            } label: {
                Image(systemName: "star")
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

struct ComicView_Previews: PreviewProvider {
    static var previews: some View {
        ComicView(showComic: .constant(true))
    }
}
