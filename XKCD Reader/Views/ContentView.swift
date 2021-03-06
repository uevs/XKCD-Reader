//
//  ContentView.swift
//  XKCD Reader
//
//  Created by leonardo on 12/04/22.
//

import SwiftUI

struct ContentView: View {
    /// The main area of the app, can display both all comics or just favorites
    
    /// The viewmodel for the app logic
    @EnvironmentObject var comics: Comics
    
    @State var main: Bool
    @State var sortLastFirst: Bool = true
    @State var showMenu = false
    @State var showFilters = false
    
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
                    
                    /// Comics are displayed here and fetched from the environmentobject's array
                    LazyVGrid(columns: [GridItem()]) {
                        ForEach(main ? comics.comics : comics.favorites, id: \.self) { comic in
                            CardView(comic: comic)
                                .padding(.top)
                        }
                    }
                    
                    Button {
                        Task {
                            await comics.fetchComics(amount: 10)
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(.black,lineWidth: 2)
                                .background(RoundedRectangle(cornerRadius: 20).fill(Color.accentColor))
                            Text("Give me more!")
                                .font(.title3).bold()
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                    .opacity(main ? 1 : 0)
                    .padding()
                    
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
