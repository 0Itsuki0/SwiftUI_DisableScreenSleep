//
//  IdleTime.swift
//
//  Created by Itsuki on 2025/12/12.
//

import SwiftUI
import Combine

struct IdleTimeDemo: View {
    @State private var disableSleep: Bool = false
    @State private var timeElapsed: Float = 0
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            VStack(spacing: 48) {
                HStack {
                    Text("Time Elapsed")
                        .lineLimit(1)
                    Spacer()
                    
                    Text("\(String(format: "%2.f", timeElapsed)) sec")
                        .contentTransition(.numericText())
                        .minimumScaleFactor(0.5)
                }
                .font(.title2)
                .fontWeight(.bold)
                
                Toggle(isOn: $disableSleep, label: {
                    Text("Awake Forever?")
                        .font(.headline)
                })
                .onChange(of: disableSleep, {
                    // A Boolean value that controls whether the idle timer is disabled for the app.
                    //
                    // IMPORTANT:
                    // 1. Only set if necessary,and reset it to false when no longer needed
                    // 2. The only apps that should disable the idle timer are mapping apps, games, or programs where the app needs to continue displaying content when user interaction is minimal
                    // 3. audio apps **should** allow the system to turn off the screen when the idle timer elapses
                    UIApplication.shared.isIdleTimerDisabled = disableSleep
                    self.timeElapsed = 0
                })
                .onReceive(timer) { _ in
                    timeElapsed += 1
                }

            }
            .padding()
            .padding(.horizontal, 48)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.yellow.opacity(0.1))
            .navigationTitle("Idle Time")
            .navigationBarTitleDisplayMode(.large)
            
        }
    }
}


#Preview {
    IdleTimeDemo()
}
