import SwiftUI

struct TimerPage: View {
    @State private var selectedHour = 0
    @State private var selectedMin = 0
    @State private var sec = 60
    
    @State private var showSettings = true
    @State private var showTimer = false
    
    let hourTimer = Timer.publish(every: 3600, on: .main, in: .common).autoconnect()
    let minTimer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    let secTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text("Work Buddy").font(.system(size: 35, design: .rounded))
            .padding(.top, 20)
        Spacer()
        VStack {
            HStack {
                Spacer()
                if showSettings {
                    Picker("Hour", selection: $selectedHour) {
                        ForEach(0..<24) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.wheel)
                    Text("hours")
                    Picker("Min", selection: $selectedMin) {
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
                    Text("\(selectedHour)")
                        .onReceive(hourTimer) { _ in
                            if selectedHour > 0 {
                                selectedHour -= 1
                            }
                        }
                    Text(" : ")
                    Text("\(selectedMin)")
                        .onReceive(minTimer) { _ in
                            if selectedMin > 0 {
                                selectedMin -= 1
                            }
                        }
                    Text(" : ")
                    Text("\(sec)")
                        .onReceive(secTimer) { _ in
                            if sec > 0 {
                                sec -= 1
                            } else if sec == 0 {
                                sec = 60
                            }
                        }
                }
            }
        }
        Spacer()
        HStack {
            Spacer()
            Button("Start") {
                showSettings = false
                showTimer = true
            }
            Spacer()
            Button("Reset") {
                showSettings = true
                showTimer = false
            }
            Spacer()
        }
        Spacer()
    }
}

struct TimerPage_Previews: PreviewProvider {
    static var previews: some View {
        TimerPage()
    }
}
