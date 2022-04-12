//
//  MainView.swift
//  ShortcutChallenge
//
//  Created by leonardo on 12/04/22.
//

import SwiftUI

struct MainView: View {
    
    @State var searchText: String = ""
    
    var body: some View {
        
        NavigationView {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Comics", systemImage: "book")
                    }
                
                ContentView()
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
                
            }
            .searchable(text: $searchText)
            .navigationTitle("Shortcut2XKCD")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis.circle")
                        
                    }
                }
                
            }
        }
        
    }
}
