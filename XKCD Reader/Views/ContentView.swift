//
//  ContentView.swift
//  XKCD Reader
//
//  Created by leonardo on 12/04/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var comics: Comics
    
    @State var main: Bool
    @State var sortLastFirst: Bool = true
    @State var showMenu = false
    @State var showFilters = false

    
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
                            showFilters.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                        }
                        .padding([.horizontal])
                    }
                    .foregroundColor(.primary)
                    
                    LazyVGrid(columns: [GridItem()]) {
                        ForEach(comics.comics, id: \.self) { comic in
                            CardView(comic: comic)
                                .padding(.top)
                        }
                    }
                }
                .navigationTitle(main ? "XKCD Reader" : "Favorites")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showMenu.toggle()
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .sheet(isPresented: $showMenu) {
                MenuView()
            }
            .sheet(isPresented: $showFilters) {
                FiltersView()
            }
        }
        .navigationViewStyle(.stack)
    }
}
