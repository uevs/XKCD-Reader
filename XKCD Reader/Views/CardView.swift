//
//  CardView.swift
//  ShortcutChallenge
//
//  Created by leonardo on 29/04/22.
//

import SwiftUI

struct CardView: View {
    @State var showComic = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.black,lineWidth: 2)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
            
            VStack(alignment: .leading) {
                Text("#0000")
                    .font(.title3)
                    .padding([.top,.horizontal])
                
                Text("Title")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding([.bottom, .horizontal])
                
                ZStack {
                    Image("security")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxHeight: 200)
                        .padding()
                    
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
            ComicView(showComic: $showComic)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
