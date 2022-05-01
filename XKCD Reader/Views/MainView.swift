//
//  MainView.swift
//  XKCD Reader
//
//  Created by leonardo on 12/04/22.
//

import SwiftUI

struct MainView: View {
    @StateObject var comics = Comics()
    
    var body: some View {
        TabView {
            ContentView(main: true)
                .tabItem {
                    Label("Comics", systemImage: "book")
                }
            
            ContentView(main: false)
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
        .environmentObject(comics)
        
    }
}









