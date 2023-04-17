//
//  ShimmerView.swift
//  Play-swift
//
//  Created by vishnu vijayan on 2023-04-13.
//

import Foundation
import SwiftUI

extension View {
    public func shimmer(_ flag: Binding<Bool>) -> some View {
        self.modifier(ShimmerModifier(start: flag))
    }
}

fileprivate struct ShimmerModifier: ViewModifier {
    
    @State private var animation: Bool = false
    
    @Binding var start: Bool
    
    func body(content: Content) -> some View {
        content.overlay(overlayContent())
        .onChange(of: start){ _ in
            animation.toggle()
        }
    }
    
    func overlayContent() -> some View {
        VStack {
            if start {
                GeometryReader { reader in
                    ZStack {
                        Color(red: 218/255,
                              green: 218/255,
                              blue: 218/255)
                        VStack {
                            LinearGradient(
                                colors: [
                                    Color.clear,
                                    Color.white.opacity(0.8),
                                    Color.clear
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(maxWidth: .infinity, maxHeight: .infinity)

                        }
                        .offset(x: -(reader.frame(in: .local).width))
                        .offset(x: animation ? (reader.frame(in: .local).width * 2.5) : 0)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .onAppear(perform: {
                        withAnimation(Animation.linear(duration: 2.5).repeatForever(autoreverses: false)){
                            animation.toggle()
                        }
                    })
                }.clipped()
            }
        }
    }
}
