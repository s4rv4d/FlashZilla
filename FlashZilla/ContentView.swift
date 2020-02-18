//
//  ContentView.swift
//  FlashZilla
//
//  Created by Sarvad shetty on 2/18/20.
//  Copyright © 2020 Sarvad shetty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //testing out gestures
    @State private var currentAmount: CGFloat = 0
    @State private var finalAmount: CGFloat = 1
    
    var body: some View {
        Text("Hello, World!")
        .scaleEffect(currentAmount + finalAmount)
            .gesture (
                MagnificationGesture()
                    .onChanged { amount in
                        self.currentAmount = amount - 1
                }
                .onEnded { amount in
                    self.finalAmount += self.currentAmount
                    self.currentAmount = 0
                }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
