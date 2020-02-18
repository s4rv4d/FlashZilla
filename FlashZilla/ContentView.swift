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
    //for magnification gesture
    @State private var currentAmount: CGFloat = 0
    @State private var finalAmount: CGFloat = 1
    //for rotation gesture
    @State private var currentAngle: Angle = .degrees(0)
    @State private var finalAngle: Angle = .degrees(0)
    
    var body: some View {
        Text("Hello, World!")
        .rotationEffect(currentAngle + finalAngle)
        .gesture(
            RotationGesture()
                .onChanged({ (angle) in
                    self.currentAngle = angle
                })
                .onEnded({ (angle) in
                    self.finalAngle += self.currentAngle
                    self.currentAngle = .degrees(0)
                })
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
