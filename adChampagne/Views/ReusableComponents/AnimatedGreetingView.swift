//
//  AnimatedGreetingView.swift
//  adChampagne
//
//  Created by Andrei Panasenko on 09.01.2023.
//

import SwiftUI

struct AnimatedGreetingView: View {
    @State var characters: Array<String.Element>
    @State var opacity: Double = 0
    @State var baseTime: Double
    
    init(text: String, startTime: Double) {
        characters = Array(text)
        baseTime = startTime
    }
    
    var body: some View {
        HStack(spacing: 0){
            ForEach(0 ..< characters.count) { num in
                Text(String(self.characters[num]))
                    .font(.title)
                    .opacity(opacity)
                    .animation(.easeInOut.delay( Double(num) * 0.05 ),
                               value: opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + baseTime){
                opacity = 1
            }
        }
    }
}
