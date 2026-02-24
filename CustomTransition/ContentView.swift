//
//  ContentView.swift
//  CustomTransition
//
//  Created by Todor Goranov on 24/02/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingImage = true
    var body: some View {
        ZStack {
            Color.black
                .frame(width: 50, height: 20)
                .cornerRadius(5)
            if isShowingImage {
                Image("Fox")
//                    .transition(.scale)
//                    .transition(.scale.combined(with: .opacity))
                    .transition(Twirl())
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 1.0)) {
                isShowingImage.toggle()
            }
        }
        .padding()
    }
}

struct Twirl: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .scaleEffect(phase.isIdentity ? 1 : 0.5)
            .opacity(phase.isIdentity ? 1 : 0)
            .blur(radius: phase.isIdentity ? 0 : 10)
            .rotationEffect(
                .degrees(
                    phase == .willAppear ? 360 :
                        phase == .didDisappear ? -360 : .zero
                )
            )
            .brightness(phase == .willAppear ? 1 : 0)
    }
}

#Preview {
    ContentView()
}
