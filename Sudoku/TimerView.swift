//
//  CountUpView.swift
//  TimerDuration
//
//  Created by Alvin Alleyne on 6/16/24.
//

import SwiftUI


struct TimerView: View {
    
    @State private var hours = 0
    @State private var minutes = 0
    @State private var seconds = 0
    @State private var timerIsPaused = true
    @State private var timer: Timer? = nil
    
    
    var body: some View {
        
        HStack {
            Text("Timer:  \(hours)h,  \(minutes)m,  \(seconds)s")
                .font(.headline).bold()
                .foregroundStyle(minutes >= 10 ? .red : .cyan)
                
            if timerIsPaused {
                Button(action: { self.restartTimer() } )  {
                    Image(systemName: "backward.end.alt")
                }
                
                Button(action: { self.startTimer() } )  {
                    Image(systemName: "play.fill")
                }
            } else {
                Button(action: { self.stopTimer() } )  {
                    Image(systemName: "stop.fill")
                }
            }
        }
        .frame(width: 220, height: 30)//, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//        .border(.secondary, width: 1)
        .padding(.bottom, 5)
    }
    
    
    func startTimer() {
        timerIsPaused = false
        // 1. Make a new timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            // 2. Check time to add to H:M:S
            if self.seconds == 59 {
                self.seconds = 0
                if self.minutes == 59 {
                    self.minutes = 0
                    self.hours = self.hours + 1
                } else {
                    self.minutes = self.minutes + 1
                }
            } else {
                self.seconds = self.seconds + 1
            }
        }
    }
    
    
    func stopTimer() {
        timerIsPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    
    func restartTimer() {
        hours = 0
        minutes = 0
        seconds = 0
    }
}



#Preview {
    TimerView()
        .preferredColorScheme(.dark)
}
