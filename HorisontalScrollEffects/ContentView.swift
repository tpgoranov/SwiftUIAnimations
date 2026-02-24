//
//  ContentView.swift
//  HorisontalScrollEffects
//
//  Created by Todor Goranov on 22/02/2026.
//

import SwiftUI

struct ContentView: View {
    @State var gradientColors: [Color] = [
        .yellow, .red, .green,
        .blue, .black, .pink,
        .green, .orange, .yellow
    ]
    
    @State var cardsColors: [Color] = [
        .red, .black, .yellow,
        .green, .pink, .blue,
        .red, .orange, .black
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
                
                ScrollView(.horizontal) {
                    HStack(spacing: 25) {
                        ForEach(0..<cardsColors.count, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 20)
                                .fill(cardsColors[index])
                                .shadow(radius: 5, x: 5, y: 5)
                                .frame(width: UIScreen.main.bounds.width - 100, height: 400)
                                .scrollTransition{ content, phase in
                                    content
                                        .rotationEffect(.degrees(phase.value * 2.5))
                                        .offset(y: phase.isIdentity ? 0 : 0)
                                }
                                .scrollTransition{ content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1: 0.5)
                                        .scaleEffect(y: phase.isIdentity ? 1 : 0.7)
                                }
                        }
                    }
                    .scrollTargetLayout() //Align content to the view
                }
                .contentMargins(50, for: .scrollContent)
                .scrollTargetBehavior(.viewAligned) //Align center behaviour
                            .scrollIndicators(.hidden)
            }
        }
    }
    
}


#Preview {
    ContentView()
}
