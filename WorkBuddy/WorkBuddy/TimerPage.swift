import SwiftUI

struct TimerPage: View {
    @State var timeRemaining = 30
    @State private var selectedHour = 0
    @State private var selectedMin = 0
    
    @State private var showSettings = true
    @State private var showTimer = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            if showSettings {
                Picker("Hours", selection: $selectedHour) {
                    ForEach(0..<24) {
                        Text("\($0) hours")
                    }
                }
                
                Picker("Min", selection: $selectedMin) {
                    ForEach(0..<60) {
                        Text("\($0) min")
                    }
                }
            }
        }
        
        HStack {
            Button("Start") {
                showSettings = false
                showTimer = true
            }
            Button("Stop") {
                showSettings = true
                showTimer = false
            }
        }
        
        VStack {
            if showTimer {
                Text("\(selectedMin)")
                    .onReceive(timer) { _ in
                        if selectedMin > 0 {
                            selectedMin -= 1
                        }
                    }
                Text("Timer!")
            }
        }
    }
}

struct TimerPage_Previews: PreviewProvider {
    static var previews: some View {
        TimerPage()
    }
}
