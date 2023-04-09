import SwiftUI

struct TimerPage: View {
    @State private var hour = 0
    @State private var min = 0
    @State private var sec = 0
        
    @State private var showSettings = true
    @State private var showTimer = false
    @State private var isPaused = false
    
    @State var hourTimer = Timer.publish(every: 3600, on: .main, in: .common).autoconnect()
    @State var minTimer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    @State var secTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
    var body: some View {
        Text("Work Buddy").font(.system(size: 35, design: .rounded))
            .padding(.top, 20)
        Spacer()
        VStack {
            HStack {
                Spacer()
                if showSettings {
                    Picker("Hour", selection: $hour) {
                        ForEach(0..<24) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.wheel)
                    Text("hours")
                    Picker("Min", selection: $min) {
                        ForEach(0..<60) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.wheel)
                    Text("min")
                }
                Spacer()
            }
            HStack {
                if showTimer {
                                        
                    Text("\(hour)")
                        .onReceive(hourTimer) { _ in
                            if hour > 0 {
                                hour -= 1
                            }
                        }
                    
                    Text(" : ")
                    
                    Text("\(min)")
                        .onReceive(minTimer) { _ in
                            if min > 0 {
                                min -= 1
                            }
                        }
                    
                    Text(" : ")
                    
                    Text("\(sec)")
                        .onReceive(secTimer) { _ in
                            if sec > 0 {
                                sec -= 1
                            } else if hour == 0 && min == 0 && sec == 0 {
                                stopTimers()
                            } else if sec == 0 && min > 0{
                                sec = 59
                            }
                        }
                }
            }
        }
        Spacer()
        HStack {
            Spacer()
            if showSettings {
                Button("Start") {
                    if hour == 0 && min == 0 && sec == 0 {
                    } else {
                        showSettings = false
                        showTimer = true
                    }
                }
            } else {
                if isPaused {
                    Button("Start") {
                        isPaused.toggle()
                        startTimers()
                    }
                } else {
                    Button("Pause") {
                        isPaused.toggle()
                        stopTimers()
                    }
                }
                Button("Reset") {
                    showSettings = true
                    showTimer = false
                    (hour, min, sec) = (0, 0, 0)
                }
            }
            
            Spacer()
        }
        Spacer()
    }
    
    func stopTimers() {
        self.hourTimer.upstream.connect().cancel()
        self.minTimer.upstream.connect().cancel()
        self.secTimer.upstream.connect().cancel()
    }
    
    func startTimers() {
        self.hourTimer = Timer.publish(every: 3600, on: .main, in: .common).autoconnect()
        self.minTimer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
        self.secTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
}

struct TimerPage_Previews: PreviewProvider {
    static var previews: some View {
        TimerPage()
    }
}
