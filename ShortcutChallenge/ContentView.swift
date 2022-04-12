//
//  ContentView.swift
//  ShortcutChallenge
//
//  Created by leonardo on 12/04/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                HStack {
                    Text("\(Image(systemName: "arrow.down")) Latest First")
                        .font(.title3)
                    
                    Spacer()
                    
                    Button {
                        //
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
                .padding([.horizontal,.bottom])
                
                Text("Comic Card")
                    .padding()
                
                NavigationLink("Link", destination: {ComicView()})
            }
            
        }
    }
}
