//
//  ContentView.swift
//  FlashZilla
//
//  Created by Sarvad shetty on 2/18/20.
//  Copyright © 2020 Sarvad shetty. All rights reserved.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {

    //MARK: - Property wrappers
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    @State private var isActive = true
    @State private var showingEditScreen = false
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    //MARK: - Properties
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                //timer here
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                )
                
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: self.cards[index]) {
                            withAnimation {
                                self.removeCard(at: index)
                            }
                        }
                            .stacked(at: index, in: self.cards.count)
                        .allowsHitTesting(index == self.cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                if cards.isEmpty {
                           Button("Start Again", action: resetCards)
                               .padding()
                               .background(Color.white)
                               .foregroundColor(.black)
                               .clipShape(Capsule())
                       }
            }
            
            //adding the plus button
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus.circle")
                        .padding()
                            .background(Color.black.opacity(0.7))
                        .clipShape(Circle())
                    }
                    Spacer()
                }
                
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor {
                VStack {
                    Spacer()
                    
                    HStack {
                        Image("xmark.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                        Spacer()
                        Image("checkmark.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards()
        }
    .onAppear(perform: resetCards)
       
        //MARK: - onRecieve modifiers
        .onReceive(timer) { (time) in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { (_) in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { (_) in
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
    }
    
    //MARK: - Methods
    func removeCard(at index: Int) {
        self.cards.remove(at: index)
        if cards.isEmpty {
            self.isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//MARK: - Extneions
extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}
