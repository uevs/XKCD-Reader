//
//  ContentView.swift
//  ShortcutChallenge
//
//  Created by leonardo on 12/04/22.
//

import SwiftUI

struct ContentView: View {
    @State var main: Bool
    @State var sortLastFirst: Bool = true
    
    let data = (1...500).map { "Item \($0)" }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                ScrollView {
                    HStack {
                        Button {
                            sortLastFirst.toggle()
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                            Text(sortLastFirst ? "Oldest First" : "Latest First")
                        }
                        .padding([.horizontal, .top])
                        
                        Spacer()
                        
                        Button {
                            //Sort
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                        .padding([.horizontal])
                    }
                    .foregroundColor(.primary)
                    
                    LazyVGrid(columns: [GridItem()], spacing: 20) {
                        ForEach(data, id: \.self) { item in
                            CardView()
                                .padding()
                        }
                        
                    }
                }
                .navigationTitle(main ? "XKCD Reader" : "Favorites")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            //Modal
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .foregroundColor(.primary)
                            
                        }
                    }
                }
            }
        }
    }
}
