//
//  ContentView.swift
//  MeshGradient
//
//  Created by Todor Goranov on 22/02/2026.
//

import SwiftUI

struct ContentView: View {
    @State var gradientColors: [Color] = [
        .black, .black, .black,
        .blue, .blue, .blue,
        .green, .green, .green
    ]

    var body: some View {
        VStack {
            ZStack {
                MeshGradient (
                    width: 3,
                    height: 3,
                    points: [
                        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                        [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                    ],
                    colors: gradientColors
                )
                .edgesIgnoringSafeArea(.all)
                .onAppear{
                    startTimer()
                }
            }
        }
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
                withAnimation(.easeInOut(duration: 1.0)) {
                    gradientColors = [
                        Color(red: .random(in: 0...1),
                              green: .random(in: 0...1),
                              blue: .random(in: 0...1)),
                        Color(red: .random(in: 0...1),
                              green: .random(in: 0...1),
                              blue: .random(in: 0...1)),
                        Color(red: .random(in: 0...1),
                              green: .random(in: 0...1),
                              blue: .random(in: 0...1)),
                        Color(red: .random(in: 0...1),
                              green: .random(in: 0...1),
                              blue: .random(in: 0...1)),
                        Color(red: .random(in: 0...1),
                              green: .random(in: 0...1),
                              blue: .random(in: 0...1)),
                        Color(red: .random(in: 0...1),
                              green: .random(in: 0...1),
                              blue: .random(in: 0...1)),
                        Color(red: .random(in: 0...1),
                              green: .random(in: 0...1),
                              blue: .random(in: 0...1)),
                        Color(red: .random(in: 0...1),
                              green: .random(in: 0...1),
                              blue: .random(in: 0...1)),
                        Color(red: .random(in: 0...1),
                              green: .random(in: 0...1),
                              blue: .random(in: 0...1)),
                    ]
                }
        }
    }
    
}


#Preview {
    ContentView()
}
