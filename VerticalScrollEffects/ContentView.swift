//
//  ContentView.swift
//  VerticalScrollEffects
//
//  Created by Todor Goranov on 22/02/2026.
//

import SwiftUI

enum TransitionOptions: String, CaseIterable {
    case offset
    case blur
    case scale
    case rotate
    case easeInOut
    case roll
}

struct Contact: Hashable, Identifiable {
    var id: String
    var name: String
    static var previewData: [Contact] {
        [
            Contact(id: UUID().uuidString, name: "Alice"),
            Contact(id: UUID().uuidString, name: "Bob"),
            Contact(id: UUID().uuidString, name: "Charlie"),
            Contact(id: UUID().uuidString, name: "Diana"),
            Contact(id: UUID().uuidString, name: "Eve"),
            Contact(id: UUID().uuidString, name: "Frank"),
            Contact(id: UUID().uuidString, name: "Grace"),
            Contact(id: UUID().uuidString, name: "Hank"),
            Contact(id: UUID().uuidString, name: "Ivy"),
            Contact(id: UUID().uuidString, name: "Jack"),
            Contact(id: UUID().uuidString, name: "Karen"),
            Contact(id: UUID().uuidString, name: "Leo"),
            Contact(id: UUID().uuidString, name: "Mona"),
            Contact(id: UUID().uuidString, name: "Nina"),
            Contact(id: UUID().uuidString, name: "Oscar"),
            Contact(id: UUID().uuidString, name: "Paul"),
            Contact(id: UUID().uuidString, name: "Quinn"),
            Contact(id: UUID().uuidString, name: "Rita"),
            Contact(id: UUID().uuidString, name: "Sam"),
            Contact(id: UUID().uuidString, name: "Tina")
        ]
    }
}

struct ContentView: View {
    private(set) var contacts: [Contact]
    
    @State private var option: TransitionOptions = .offset
    var body: some View {
        VStack{
            Picker("Animation Options:", selection: $option) {
                ForEach(TransitionOptions.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            ScrollView {
                VStack{
                    ForEach(contacts) { contact in
                        RoundedRectangle(cornerRadius: 24)
                            .fill(.purple)
                            .modifier(OptionsViewModifier(option: $option))
                            .frame(height: 100)
                            .padding(.horizontal, 10)
                            .visualEffect{
                                content, proxy in
                                content.hueRotation(Angle(degrees: proxy.frame(in: .global).origin.y / 10))
                            }
//                            .visualEffect{
//                                content, proxy in
//                                content.rotationEffect(Angle(degrees: proxy.frame(in: .global).origin.y / 2))
//                            }
                    }
                }
            }
        }

    }
}
struct OptionsViewModifier: ViewModifier {
    @Binding var option: TransitionOptions
    func body(content: Content) -> some View {
        switch option {
        case .offset:
            content
                .scrollTransition{ content, phase in
                    content
                        .offset(phase.isIdentity ? CGSize.zero : CGSize(width: 250, height: 0))
                }
        case .blur:
            content
                .scrollTransition{ content, phase in
                    content
                        .opacity(phase.isIdentity || phase.value < 1 ? 1 : 0)
                        .scaleEffect(phase.isIdentity || phase.value < 1 ? 1 : 0.75)
                        .blur(radius: phase.isIdentity || phase.value < 1 ? 0 : 10)
                }
        case .scale:
            content
                .scrollTransition{ content, phase in
                    content
                        .scaleEffect(phase.isIdentity || phase.value < 1 ? 1 : 10)
                        .opacity(phase.isIdentity || phase.value < 1 ? 1 : -10)
                }
        case .rotate:
            content
                .scrollTransition{ content, phase in
                    content
                        .rotation3DEffect(phase.isIdentity || phase.value < 1 ? Angle.degrees(0) : Angle.degrees(100), axis: (0, 90, 0))
                }
        case .easeInOut:
            content
                .scrollTransition{ content, phase in
                    content
                        .scaleEffect(phase.isIdentity ? CGSize.zero : phase.value < 1 ?
                                     CGSize(width: 0, height: -100) :
                                     CGSize(width: 0, height: 100))
                }
        case .roll:
            content
                .scrollTransition{ content, phase in
                    content
                        .rotationEffect(phase.isIdentity ? Angle(degrees: 0) :
                                                            Angle(degrees: 120))
                        .scaleEffect(phase.isIdentity ? CGSize.zero : phase.value < 1 ?
                                     CGSize(width: 0, height: -200) : CGSize(width: 0, height: 200))
                }
        }
    }
}

#Preview {
    ContentView(contacts: Contact.previewData)
}
