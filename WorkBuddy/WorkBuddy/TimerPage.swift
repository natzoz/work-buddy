import SwiftUI

struct TimerPage: View {
    @State var timeRemaining = 30
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        VStack {
            Text("\(timeRemaining)")
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
            Text("Timer!")
        }
    }
}

struct TimerPage_Previews: PreviewProvider {
    static var previews: some View {
        TimerPage()
    }
}
