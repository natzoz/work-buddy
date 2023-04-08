//
//  HomePage.swift
//  WorkBuddy
//
//  Created by cs-488-01 on 4/8/23.
//
import SwiftUI

struct TaskPage: View {
    @State private var Timer = true
    @State private var Task = false
    var body: some View{
            if Timer {
                VStack{
                    //TimerPage()
                    HStack{
                        Button("Timer"){}.buttonStyle(.bordered).bold()
                        Button("Task"){
                            Timer.toggle()
                            Task.toggle()
                        }.buttonStyle(.bordered)
                    }
                    }
            }else if Task{
                VStack{
                    VStack{
                        List{
                            //ForEach(Taskcell){ task in Taskcell()
                            Taskcell(task: "do code for this")
                        }
                    }
                    
                    HStack{
                        Button("Task"){}.buttonStyle(.bordered).bold()
                        Button("Timer"){
                            Timer.toggle()
                            Task.toggle()
                        }.buttonStyle(.bordered)
                    }
                }
            }
            }
        
        
    }


struct Taskcell: View{
    var task: String
    var body: some View{
        Text(task)
        VStack{
            Text("hello")
        }
    }
}


struct TaskPage_Previews: PreviewProvider{
    static var previews: some View{
        TaskPage()
    }
}
