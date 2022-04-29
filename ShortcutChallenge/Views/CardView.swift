//
//  CardView.swift
//  ShortcutChallenge
//
//  Created by leonardo on 29/04/22.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.black,lineWidth: 2)
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("#0000")
                            .font(.title3)
            
                        Text("Title")
                            .font(.title)
                    }
                    
                    Spacer()
                }
                .foregroundColor(.black)
                .padding()
                
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
                                // Modal
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
        .padding()
        .frame(width: UIScreen.main.bounds.width, height: 300)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
